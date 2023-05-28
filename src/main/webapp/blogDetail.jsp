<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.fptuniversity.swp391_su23_group1_onlineshop.model.Post"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Blog detail</title>
        <link rel="stylesheet" href="styles/tailwindcss/tailwind-all.min.css">
    </head>
    <body>
        <jsp:include page="components/header.jsp" />
        <%
            Post post = (Post) request.getAttribute("post");
        %>

        <div class="container mx-auto py-6">
            <h1 class="text-3xl font-bold mb-4">Blog Detail</h1>
            <div class="sorting-bar">
                <label for="sort-select">Sort By:</label>
                <select id="sort-select" onchange="appendParameter('sort', this.value)">
                    <option value="none">---</option>
                    <option value="created_at~DESC">Sort by Latest Date</option>
                    <option value="created_at~ASC">Sort by Oldest Date</option>
                    <option value="name~ASC">Sort by A-Z</option>
                    <option value="name~DESC">Sort by Z-A</option>
                    <option value="none">Sort by Rating</option>
                    <option value="price~ASC">Sort by Price: Low to High</option>
                    <option value="price~DESC">Sort by Price: High to Low</option>
                </select>
            </div>
            <div class="bg-white rounded shadow p-6">
                <img class=" h-64 object-cover object-center mb-6" src="<%= post.getThumbnailUrl()%>" alt="Post Thumbnail">
                <h2 class="text-2xl font-bold mb-4"><%= post.getTitle()%></h2>
                <p class="text-gray-500 mb-4"> <%= post.getCreatedAt()%> - <%= "ABC"%></p>
                <p><%= post.getContent()%></p>
            </div>
            <div class="flex"> 
                <%
                    int totalPage = (int) request.getAttribute("totalPage");
                    for (int i = 1; i <= totalPage; i++) {
                %>
                <button onclick="appendParameter('page',<%=i%>)" class="bg-red-200 p-2 m-2"><%=i%></button>

                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
