<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entities.Admin" %>

<jsp:useBean id="dbUtil" class="utils.DBUtil"></jsp:useBean>

<% Admin adm = dbUtil.isLogin(request, response); %>

<!doctype html>
<html lang="en">

<head>
  <title>Kasa Yönetimi / Ödeme Girişi</title>
  <jsp:include page="inc/css.jsp"></jsp:include>
</head>

<body>

<div class="wrapper d-flex align-items-stretch">
  <jsp:include page="inc/sideBar.jsp"></jsp:include>
  <div id="content" class="p-4 p-md-5">
    <jsp:include page="inc/topMenu.jsp"></jsp:include>
    <h3 class="mb-3">
      <a href="payOut.jsp" class="btn btn-danger float-right">Ödeme Çıkışı</a>
      Kasa Yönetimi
      <small class="h6">Ödeme Girişi</small>
    </h3>


    <div class="main-card mb-3 card mainCart">
      <div class="card-header cardHeader">Ödeme Ekle</div>

      <form class="row p-3" id="payIn_add_form">

        <div class="col-md-3 mb-3">
          <label for="cname" class="form-label">Müşteriler</label>
          <select  id="cname" class="selectpicker" data-width="100%" data-show-subtext="true" data-live-search="true">
            <option data-subtext="">Seçim Yapınız</option>
            <c:forEach items="${ dbUtil.customerList()}" var="item">
              <option value="${item.cu_id}" data-subtext="<c:out value="${item.cu_code}"></c:out>"><c:out value="${item.cu_name }"></c:out> <c:out value="${item.cu_surname }"></c:out></option>

            </c:forEach>
          </select>
        </div>

        <div class="col-md-3 mb-3">
          <label for="cbNo" class="form-label">Müşteri Fişleri</label>
          <select id="cbNo" class="selectpicker" data-width="100%" data-show-subtext="true" data-live-search="true">
            <option data-subtext="">Seçim Yapınız</option>

          </select>
        </div>

        <div class="col-md-3 mb-3">
          <label for="payInTotal" class="form-label">Ödeme Tutarı</label>
          <input type="number" name="payInTotal" id="payInTotal" class="form-control" />
        </div>

        <div class="col-md-3 mb-3">
          <label for="payInDetail" class="form-label">Ödeme Detay</label>
          <input type="text" name="payInDetail" id="payInDetail" class="form-control" />
        </div>




        <div class="btn-group col-md-3 " role="group">
          <button type="submit" class="btn btn-outline-primary mr-1">Gönder</button>
          <button type="reset" class="btn btn-outline-primary">Temizle</button>
        </div>
      </form>
    </div>


    <div class="main-card mb-3 card mainCart">
      <div class="card-header cardHeader">Ödeme Giriş Listesi</div>

      <div class="row mt-3" style="padding-right: 15px; padding-left: 15px;">
        <div class="col-sm-3"></div>
        <div class="col-sm-3"></div>
        <div class="col-sm-3"></div>
        <div class="col-sm-3">
          <div class="input-group flex-nowrap">
            <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search"></i></span>
            <input type="text" class="form-control" placeholder="Arama.." aria-label="Username" aria-describedby="addon-wrapping">
            <button class="btn btn-outline-primary">Ara</button>
          </div>
        </div>



      </div>
      <div class="table-responsive">
        <table class="align-middle mb-0 table table-borderless table-striped table-hover">
          <thead>
          <tr>
            <th>Id</th>
            <th>Adı</th>
            <th>Soyadı</th>
            <th>Fiş No</th>
            <th>Ödeme Tutarı</th>
            <th class="text-center" style="width: 155px;" >Yönetim</th>
          </tr>
          </thead>
          <tbody class="tableRow">
          <!-- for loop  -->

          </tbody>
        </table>
      </div>
    </div>


  </div>
</div>
</div>
<jsp:include page="inc/js.jsp"></jsp:include>
<script src="js/payIn.js"></script>
</body>

</html>

