

<%@page import="com.fptuniversity.swp391_su23_group1_onlineshop.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="styles/tailwindcss/tailwind-all.min.css">
        <title>Profile</title>
    </head>
    <body>
        <jsp:include page="components/header.jsp" />

        <%
            User userInfomation = (User) request.getAttribute("userInfomation");
        %>

        <table>
            <tr>
                <th>Username:</th>
                <td><%= userInfomation.getUsername()%></td>
            </tr>
            <tr>
                <th>Full Name:</th>
                <td><%= userInfomation.getFullname()%></td>
            </tr>
            <tr>
                <th>Phone:</th>
                <td><%= userInfomation.getPhone()%></td>
            </tr>
            <tr>
                <th>Address:</th>
                <td><%= userInfomation.getAddress()%></td>
            </tr>
            <tr>
                <th>Email:</th>
                <td><%= userInfomation.getEmail()%></td>
            </tr>
        </table>
        <jsp:include page="components/footer.jsp" />
    </body>
</html>
