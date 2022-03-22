<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
</head>
<body>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2>관리자 페이지입니다</h2>
<div class="container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>User</th>
                <th>Roles</th>
            </tr>
        </thead>
        <tbody> 
            <c:forEach var="b" items="${res}">
                <tr>
                    <td>${b.user_id }</td>
                    <td>
                      ${b.user_auth }
                  </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>