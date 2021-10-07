let select_id = 0
$('#payIn_add_form').submit( ( event ) => {
    event.preventDefault();

    const cname = $("#cname").val()
    const cbNo = $("#cbNo").val()
    const payInTotal = $("#payInTotal").val()
    const payInDetail = $("#payInDetail").val()



    const obj = {
        pay_customer_id: cname,
        pay_bno: cbNo,
        pay_price: payInTotal,
        pay_detail: payInDetail,

    }

    if ( select_id != 0 ) {
        // update
        obj["pay_id"] = select_id;
    }
    $.ajax({
        url: './payIn-post',
        type: 'POST',
        data: { obj: JSON.stringify(obj) },
        dataType: 'JSON',
        success: function (data) {
            if ( data > 0 ) {
                alert("İşlem Başarılı")
                allPayIn(selectedCustomer);

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
function allPayIn(cid) {
    alert(cid)
    $.ajax({
        url: './payIn-get?cid='+cid,
        type: 'GET',
        dataType: 'Json',
        success: function (data) {
            console.log(data)

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
        console.log(itm);

        html += `<tr role="row" class="odd">
            <td>`+itm[0].pay_id+`</td>
            <td>`+itm[1].cu_name+` </td>
            <td>`+itm[1].cu_surname+` </td>
            <td>`+itm[0].pay_bno+`</td>
            <td>`+itm[0].pay_price+`</td>
            <td class="text-right" >
              <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                <button onclick="fncPayInDelete(`+itm.pay_id+`)" type="button" class="btn btn-outline-primary "><i class="far fa-trash-alt"></i></button>
              
              </div>
            </td>
          </tr>`;
    }
    $('#tableRow').html(html);
}


function fncPayInDelete(pay_id){

    let answer = confirm("Silmek istediğinizden emin misniz?");

    if ( answer ) {

        $.ajax({
            url: './payIn-delete?pay_id='+pay_id,
            type: 'DELETE',
            dataType: 'text',
            success: function (data) {
                if ( data != "0" ) {
                    allPayIn(selectedCustomer);
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
let selectedCustomer = 0;
$("#cname").on("change",function (){
    selectedCustomer = (this.value)
    allPayIn(this.value)
})
