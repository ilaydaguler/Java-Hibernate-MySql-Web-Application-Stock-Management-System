
// add - start
let select_id = 0
$('#payOut_add_form').submit( ( event ) => {
    event.preventDefault();

    const payOutTitle = $("#payOutTitle").val()
    const payOutType = $("#payOutType").val()
    const payOutTotal = $("#payOutTotal").val()
    const payOutDetail = $("#payOutDetail").val()


    const obj = {
        po_title: payOutTitle,
        po_type: payOutType,
        po_total: payOutTotal,
        po_detail: payOutDetail,

    }

    if ( select_id != 0 ) {
        // update
        obj["po_id"] = select_id;
    }
    $.ajax({
        url: './payOut-post',
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
// add - end

// all payout list - start
function allPayOut() {

    $.ajax({
        url: './payOut-get',
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

        let new_type = ""
        if (itm.po_type == 0){
            new_type = 'Nakit'

        }else if(itm.po_type == 1){
            new_type = 'Kredi Kartı'
        }else if(itm.po_type == 2){
            new_type = 'Havale'
        }else if(itm.po_type == 3){
            new_type = 'EFT'
        }else if (itm.p_unit == 4){
            new_type = 'Banka Çeki'
        }
        const type = new_type;

        html += `<tr role="row" class="odd">
            <td>`+itm.po_id+`</td>
            <td>`+itm.po_title+`</td>
            <td>`+ type +`</td>
            <td>`+itm.po_total+`</td>
            <td>`+itm.po_detail+`</td>
            <td class="text-right" >
              <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                <button onclick="fncPayOutDelete(`+itm.po_id+`)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
                <button onclick="fncPayOutDetail(`+i+`)" data-bs-toggle="modal" data-bs-target="#payOutModel" type="button" class="btn btn-outline-primary "><i class="far fa-file-alt"></i></button>
                <button onclick="fncPayOutUpdate(`+i+`)" type="button" class="btn btn-outline-primary "><i class="fas fa-pencil-alt"></i></button>
              </div>
            </td>
          </tr>`;
    }
    $('#tableRow').html(html);
}

allPayOut();
// all payout list - end


//reset fnc
function fncReset(){
    select_id = 0;
    $('#payOut_add_form').trigger("reset");
    allPayOut();

}



function fncPayOutDelete( po_id ) {
    let answer = confirm("Silmek istediğinizden emin misniz?");
    if ( answer ) {

        $.ajax({
            url: './payOut-delete?po_id='+po_id,
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
function fncPayOutDetail(i){

    const itm = globalArr[i];

    let new_pay_type = ""
    if(itm.po_type == 0){
        new_pay_type = 'Nakit'
    }
    else if(itm.po_type == 1){
        new_pay_type = 'Kredi Kartı'
    }
    else if(itm.po_type == 2){
        new_pay_type = 'Havale'
    }
    else if(itm.po_type == 3){
        new_pay_type = 'EFT'
    }
    else if(itm.po_type == 4){
        new_pay_type = 'Banka Çeki'
    }

    const pay_type = new_pay_type;

    $("#po_title").text(itm.po_title.toUpperCase() + " - " + itm.po_id);
    $("#po_type").text(pay_type);
    $("#po_total").text(itm.po_total == "" ? '------' : itm.po_total);
    $("#po_detail").text(itm.po_detail== "" ? '------' : itm.po_detail);

}

function fncPayOutUpdate( i ) {
    const itm = globalArr[i];
    select_id = itm.po_id
    $("#payOutTitle").val(itm.po_title)
    $("#payOutType").val(itm.po_type)
    $("#payOutTotal").val(itm.po_total)
    $("#payOutDetail").val(itm.po_detail)


}