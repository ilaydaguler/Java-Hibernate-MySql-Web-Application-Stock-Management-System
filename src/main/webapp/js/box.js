let select_id = 0
$('#box_add_form').submit( ( event ) => {
    event.preventDefault();

    const cname = $("#cname").val()
    const pname = $("#pname").val()
    const count = $("#count").val()
    const bNo = $("#bNo").val()



    const obj = {
        b_customer_id: cname,
        b_product_id: pname,
        b_count: count,
        b_bno: bNo,

    }

    if ( select_id != 0 ) {
        // update
        obj["b_id"] = select_id;
    }
    $.ajax({
        url: './box-post',
        type: 'POST',
        data: { obj: JSON.stringify(obj) },
        dataType: 'JSON',
        success: function (data) {
            if ( data > 0 ) {
                alert("İşlem Başarılı")
                allBox(selectedCustomer);

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
// all cusomer list - start
function allBox(cid) {

    $.ajax({
        url: './box-get?cid='+cid,
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

        html += `<tr role="row" class="odd">
            <td>`+itm.b_id+`</td>
            <td>`+itm.cu_name+" "+itm.cu_surname+`</td>
            <td>`+itm.p_title+`</td>
            <td>`+itm.p_sales_price+`</td>
            <td>`+itm.b_count+`</td>
            <td>`+itm.b_bno+`</td>        
            <td class="text-right" >
              <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                <button onclick="fncBoxDelete(`+itm.b_id+`)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
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
    $('#ccode').val( key )
    $('#pcode').val( key )
    $('#bNo').val(key)
}
allBox();



// box delete - start
function fncBoxDelete(b_id){

    let answer = confirm("Silmek istediğinizden emin misniz?");

    if ( answer ) {

        $.ajax({
            url: './box-delete?b_id='+b_id,
            type: 'DELETE',
            dataType: 'text',
            success: function (data) {
                if ( data != "0" ) {
                    allBox(selectedCustomer);
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
// box delete - end

let selectedCustomer = 0;
$("#cname").on("change",function (){
    selectedCustomer = (this.value)
    allBox(this.value)
})