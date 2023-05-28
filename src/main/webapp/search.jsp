
<%@page import="com.fptuniversity.swp391_su23_group1_onlineshop.model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/tailwindcss/tailwind-all.min.css">
        <link rel="stylesheet" href="styles/css/product.css"/>
        <script src="script/index.js"></script>
        <title>Search</title>
    </head>
    <body>
        <jsp:include page="components/header.jsp" />
        <div class="w-full p-6">
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
            <div class="product-list">
                <%
                    ArrayList<Product> listProducts = (ArrayList<Product>) request.getAttribute("listProducts");
                    for (int i = 0; i < listProducts.size(); i++) {
                        Product item = listProducts.get(i);
                        int productId = item.getId();
                        String productThumbnailUrl = item.getThumbnailUrl();
                        String productName = item.getName();
                        float productPrice = item.getPrice();
                %>
                <a class="product-card" href="?id=<%=productId%>">
                    <img class="product-image" src="<%=productThumbnailUrl%>" alt="<%=productName%>">
                    <h2 class="text-lg font-bold"><%=productName%></h2>
                    <p><%=productPrice%></p>
                </a>
                <%
                    }
                %>


            </div>

            <div class="flex"> 
                <%
                    int totalPageProduct = (int) request.getAttribute("totalPageProduct");
                    for (int i = 1; i <= totalPageProduct; i++) {
                %>
                <button onclick="appendParameter('pageProduct',<%=i%>)" class="bg-red-200 p-2 m-2"><%=i%></button>

                <%
                    }
                %>
            </div>
        </div>
        <jsp:include page="components/footer.jsp" />
    </body>
</html>
