<%@page import="com.fptuniversity.swp391_su23_group1_onlineshop.model.User"%>


<% 
    User account = (User) request.getSession().getAttribute("account_infomation");  
%>
<div class=""flex flex-col-1 font-sans>
    <div class="bg-black text-white font-bold text-lg text-center mb-2">
        <div>Free shipping on Orders Over $50</div>
    </div>
    <div class="flex flex-1 justify-between mx-8">
        <div>
            <a class="font-extrabold text-2xl" href="./">Mon'sa</a>
        </div>
        <div class="flex flex-1 justify-center font-bold text-lg">
            <div class="mx-2">
                <a href="home">
                    HOME
                </a>
            </div >
            <div class="mx-2">
                <a href="shop">
                    SHOP
                </a>
            </div>
            <div class="mx-2">                
                <a href="#">
                    PAGES
                </a>
            </div>
            <div class="mx-2">
                <a href="blog">
                    BLOG
                </a>
            </div>
        </div>
        <div>
            <%
                if(account != null){
            %>
            <h2 class="inline-block">Hello <b><%=account.getFullname()%></b></h2>
            |
            <form class="inline-block" action="logout" method="POST">
                <button type="submit">
                    Logout
                </button>
            </form>
            <%
            }else{
            %>
            <a href="login">
                Login
            </a>
            |
            <a href="register">
                Register
            </a>
            <%
          }
            %>


        </div>
    </div>
</div>