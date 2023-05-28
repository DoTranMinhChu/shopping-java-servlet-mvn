
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.fptuniversity.swp391_su23_group1_onlineshop.model.Color"%>
<%@page import="com.fptuniversity.swp391_su23_group1_onlineshop.model.Product"%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Shopping</title>
        <link rel="stylesheet" href="styles/tailwindcss/tailwind-all.min.css">
        <link rel="stylesheet" href="styles/css/product.css"/>
        <script src="script/index.js"></script>
    </head>
    <body>
        <%
            // Retrieve filter values from the query parameters
            String parProductName = request.getParameter("productName");
            if (parProductName != null && parProductName.isEmpty()) {
                parProductName = null;
            }
            String parMinPricePrice = request.getParameter("minPrice");
            if (parMinPricePrice != null && parMinPricePrice.isEmpty()) {
                parMinPricePrice = null;
            }
            String parMaxPricePrice = request.getParameter("maxPrice");
            if (parMaxPricePrice != null && parMaxPricePrice.isEmpty()) {
                parMaxPricePrice = null;
            }
            String parCategoryId = request.getParameter("categoryId");
            if (parCategoryId != null && parCategoryId.isEmpty()) {
                parCategoryId = null;
            }
            System.out.println("parCategoryId " + parCategoryId == "1");
            String parColorId = request.getParameter("colorId");
            if (parColorId != null && parColorId.isEmpty()) {
                parColorId = null;
            }
            String parRating = request.getParameter("rating");
            if (parRating != null && parRating.isEmpty()) {
                parRating = null;
            }


        %>
        <jsp:include page="components/header.jsp" />
        <div class="container mx-auto p-6">
            <h1 class="text-3xl font-bold mb-4">Product Filtering</h1>
            <div class="bg-white rounded flex">
                <div class="w-1/3">
                    <form method="get" action="shopping">
                        <div class="mb-4">
                            <label class="block mb-2" for="productName">Product Name:</label>
                            <input type="text" id="productName" name="productName" <%=parProductName != null ? "value=" + parProductName : ""%>  class="border border-gray-300 rounded-md py-2 px-4 w-full">
                        </div>

                        <div class="mb-4">
                            <label class="block mb-2" for="minPrice">Min Price:</label>
                            <input type="number" id="minPrice" name="minPrice" <%=parMinPricePrice != null ? "value=" + Float.parseFloat(parMinPricePrice) : ""%> " class="border border-gray-300 rounded-md py-2 px-4 w-full">
                        </div>

                        <div class="mb-4">
                            <label class="block mb-2" for="maxPrice">Max Price:</label>
                            <input type="number" id="maxPrice" name="maxPrice" <%=parMaxPricePrice != null ? "value=" + Float.parseFloat(parMaxPricePrice) : ""%> " class="border border-gray-300 rounded-md py-2 px-4 w-full">
                        </div>
                        <div class="mb-4">
                            <label class="block mb-2" for="rating">Rating</label>
                            <input type="number" id="rating" name="rating" value="<%=parRating != null ? "value=" + Float.parseFloat(parRating) : ""%> " class="border border-gray-300 rounded-md py-2 px-4 w-full">
                        </div>

                        <div class="mb-4">
                            <label class="block mb-2" for="categoryId">Category:</label>
                            <select id="categoryId" name="categoryId" class="border border-gray-300 rounded-md py-2 px-4 w-full">
                                <option value="">All</option>
                                <option value="1" <%= (parCategoryId != null && Integer.parseInt(parCategoryId) == 1) ? "selected" : ""%>>Category 1</option>
                                <option value="2" <%= (parCategoryId != null && Integer.parseInt(parCategoryId) == 2) ? "selected" : ""%>>Category 2</option>
                                <!-- Add more category options as needed -->
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="block mb-2" for="colorId">Color:</label>
                            <select id="colorId" name="colorId" class="border border-gray-300 rounded-md py-2 px-4 w-full">
                                <option value="">--</option>
                                <%
                                    ArrayList<Color> colors = (ArrayList<Color>) request.getAttribute("colors");

                                    for (Color color : colors) {
                                %>
                                <option value=<%=color.getId()%> <%= (parColorId != null && Integer.parseInt(parColorId) == color.getId()) ? "selected" : ""%>><%=color.getName()%></option>

                                <%
                                    }
                                %>
                                <!-- Add more color options as needed -->
                            </select>
                        </div>

                        <div class="mt-8">
                            <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">Filter</button>
                        </div>
                    </form>
                </div>

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
                            int totalPage = (int) request.getAttribute("totalPage");
                            for (int i = 1; i <= totalPage; i++) {
                        %>
                        <button onclick="appendParameter('page',<%=i%>)" class="bg-red-200 p-2 m-2"><%=i%></button>

                        <%
                            }
                        %>
                    </div>
                </div>

            </div>


        </div>

    </body>
</html>



</body>
</html>
