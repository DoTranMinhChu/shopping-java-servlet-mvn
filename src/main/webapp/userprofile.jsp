

<%@page import="com.fptuniversity.swp391_su23_group1_onlineshop.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/tailwindcss/tailwind-all.min.css">
        <link rel="stylesheet" href="styles/css/userProfiler.css">
        <title>Profile</title>
    </head>
    <body>
        <jsp:include page="components/header.jsp" />

        <%
            User userProfile = (User) request.getAttribute("userInfomation");
        %>

        <form class="max-w-4xl mx-auto my-8" method="post" action="updateProfile.jsp" enctype="multipart/form-data">
            <div class="avatar-container">
                <img class="avatar" src="<%=userProfile.getAvatar() != null ? userProfile.getAvatar() : "assets/images/defaultAvatar.jpg"%>" alt="Avatar">

                <div class="w-full">
                    <div class="mb-4">
                        <label class="block text-sm font-bold mb-2" for="name">Name:</label>
                        <input class="border rounded px-3 py-2 w-full" type="text" id="name" name="name" value="<%= userProfile.getFullname() != null ? userProfile.getFullname() : ""%>">
                    </div>

                    <div class="mb-4">
                        <label class="block text-sm font-bold mb-2" for="email">Email:</label>
                        <input class="border rounded px-3 py-2 w-full" type="email" id="email" name="email" value="<%= userProfile.getEmail()!= null ? userProfile.getFullname() : ""%>">
                    </div>

                    <div class="mb-4">
                        <label class="block text-sm font-bold mb-2" for="oldPassword">Old Password:</label>
                        <input class="border rounded px-3 py-2 w-full" type="password" id="oldPassword" name="oldPassword">
                    </div>

                    <div class="mb-4">
                        <label class="block text-sm font-bold mb-2" for="newPassword">New Password:</label>
                        <input class="border rounded px-3 py-2 w-full" type="password" id="newPassword" name="newPassword">
                    </div>

                    <div class="mb-4">
                        <label class="block text-sm font-bold mb-2" for="confirmPassword">Confirm Password:</label>
                        <input class="border rounded px-3 py-2 w-full" type="password" id="confirmPassword" name="confirmPassword">
                    </div>
                </div>
            </div>

            <input class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" type="submit" value="Update Profile">
        </form>
        <jsp:include page="components/footer.jsp" />
    </body>
</html>
