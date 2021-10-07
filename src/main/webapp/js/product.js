let select_id = 0
$('#product_add_form').submit( ( event ) => {
    event.preventDefault();

    const ptitle = $("#ptitle").val()
    const aprice = $("#aprice").val()
    const oprice = $("#oprice").val()
    const pcode = $("#pcode").val()
    const ptax = $("#ptax").val()
    const psection = $("#psection").val()
    const size = $("#size").val()
    const pdetail = $("#pdetail").val()


    const obj = {
        p_title: ptitle,
        p_purchase_price: aprice,
        p_sales_price: oprice,
        p_code: pcode,
        p_KDV: ptax,
        p_unit: psection,
        p_amount: size,
        p_detail: pdetail,

    }

    if ( select_id != 0 ) {
        // update
        obj["p_id"] = select_id;
    }
    $.ajax({
        url: './product-post',
        type: 'POST',
        data: { obj: JSON.stringify(obj) },
        dataType: 'JSON',
        success: function (data) {
            if ( data > 0 ) {
                alert("İşlem Başarılı")
                fncReset();
            }else {
                alert("İşlem sırasında hata oluştu!");
            }
        },
        error: function (err) {
            console.log(err)
            alert("Ekleme işlemi sırısında bir hata oluştu!");
        }
    })


})

function allProduct() {

    $.ajax({
        url: './product-get',
        type: 'GET',
        dataType: 'Json',
        success: function (data) {
            createRow(data);
        },
        error: function (err) {
            console.log(err)
        }
    })

}

let globalArr = []
function createRow( data ) {
    globalArr = data;
    let html = ``
    for (let i = 0; i < data.length; i++) {
        const itm = data[i];
        let new_kdv =""
        if(itm.p_KDV == 1) {
            new_kdv = '%1'
        }else if(itm.p_KDV == 2){
            new_kdv = '%8'
        }else if(itm.p_KDV == 3){
            new_kdv = '%18'
        }
        const kdv = new_kdv;
        let new_unit = ""
        if (itm.p_unit == 1){
            new_unit = 'Adet'

        }else if(itm.p_unit == 2){
            new_unit = 'KG'
        }else if(itm.p_unit == 3){
            new_unit = 'Metre'
        }else if(itm.p_unit == 4){
            new_unit = 'Paket'
        }else if (itm.p_unit == 5){
            new_unit = 'Litre'
        }
        const unit = new_unit;
        html += `<tr role="row" class="odd">
            <td>`+itm.p_id+`</td>
            <td>`+itm.p_title+`</td>
            <td>`+itm.p_purchase_price+`</td>
            <td>`+itm.p_sales_price+`</td>
            <td>`+itm.p_code+`</td>
            <td>`+ kdv +`</td>
            <td>`+unit+`</td>
            <td>`+itm.p_amount+`</td>
            <td>`+itm.p_detail+`</td>
            <td class="text-right" >
              <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                <button onclick="fncProductDelete(`+itm.p_id+`)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
                <button onclick="fncProductDetail(`+i+`)" data-bs-toggle="modal" data-bs-target="#productDetailModel" type="button" class="btn btn-outline-primary "><i class="far fa-file-alt"></i></button>
                <button onclick="fncProductUpdate(`+i+`)" type="button" class="btn btn-outline-primary "><i class="fas fa-pencil-alt"></i></button>
              </div>
            </td>
          </tr>`;
    }
    $('#tableRow').html(html);
}

function codeGenerator() {
    const date = new Date();
    const time = date.getTime();
    const key = time.toString().substring(4);
    $('#pcode').val( key )
    $('#ccode').val(key)
    $('#bNo').val(key)
}
allProduct();



//reset fnc
function fncReset(){
    select_id = 0;
    $('#product_add_form').trigger("reset");
    codeGenerator();
    allProduct();

}




function fncProductDelete( p_id ) {
    let answer = confirm("Silmek istediğinizden emin misniz?");
    if ( answer ) {

        $.ajax({
            url: './product-delete?p_id='+p_id,
            type: 'DELETE',
            dataType: 'text',
            success: function (data) {
                if ( data != "0" ) {
                    fncReset();
                }else {
                    alert("Silme sırasında bir hata oluştu!");
                }
            },
            error: function (err) {
                console.log(err)
            }
        })
    }
}

function fncProductDetail(i){

    const itm = globalArr[i];
    let new_kdv =""
    if(itm.p_KDV == 1) {
        new_kdv = '%1'
    }else if(itm.p_KDV == 2){
        new_kdv = '%8'
    }else if(itm.p_KDV == 3){
        new_kdv = '%18'
    }
    const kdv = new_kdv;

    let new_unit = ""
    if (itm.p_unit == 1){
        new_unit = 'Adet'

    }else if(itm.p_unit == 2){
        new_unit = 'KG'
    }else if(itm.p_unit == 3){
        new_unit = 'Metre'
    }else if(itm.p_unit == 4){
        new_unit = 'Paket'
    }else if (itm.p_unit == 5){
        new_unit = 'Litre'
    }
    const unit = new_unit;
    $("#p_title").text(itm.p_title.toUpperCase() + " - " + itm.p_id);
    $("#p_purchase_price").text(itm.p_purchase_price == "" ? '------' : itm.p_purchase_price);
    $("#p_sales_price").text(itm.p_sales_price== "" ? '------' : itm.p_sales_price);
    $("#p_code").text(itm.p_code == "" ? '------' : itm.p_code);
    $("#p_KDV").text(kdv);
    $("#p_unit").text(unit);
    $("#p_amount").text(itm.p_amount == "" ? '------' : itm.p_amount);
    $("#p_detail").text(itm.p_detail == "" ? '------' : itm.p_detail);

}

function fncProductUpdate( i ) {
    const itm = globalArr[i];
    select_id = itm.p_id
    $("#ptitle").val(itm.p_title)
    $("#aprice").val(itm.p_purchase_price)
    $("#oprice").val(itm.p_sales_price)
    $("#pcode").val(itm.p_code)
    $("#ptax").val(itm.p_KDV)
    $("#psection").val(itm.p_unit)
    $("#size").val(itm.p_amount)
    $("#pdetail").val(itm.p_detail)

}