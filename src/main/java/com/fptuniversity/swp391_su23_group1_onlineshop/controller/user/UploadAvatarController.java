/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fptuniversity.swp391_su23_group1_onlineshop.controller.user;

import com.fptuniversity.swp391_su23_group1_onlineshop.dao.UserDao;
import com.fptuniversity.swp391_su23_group1_onlineshop.model.User;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.http.Part;
import java.net.URLEncoder;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UploadAvatarController", urlPatterns = {"/upload-avatar"})
@MultipartConfig
public class UploadAvatarController extends HttpServlet {

    private static final String PROFILE_PAGE = "userProfile";
    private static final String SESSION_ACCOUNT_INFOMATION = "account_infomation";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Part part = request.getPart("image");
        InputStream fileInputStream = part.getInputStream();

        try {
            // Convert the image file to Base64 encoding
            byte[] imageData = fileInputStream.readAllBytes();
            String base64Image = Base64.getEncoder().encodeToString(imageData);

            // Make the API request to ImgBB
            String apiKey = "c6129008f002d0ce594896a5236edc4a";
            String apiEndpoint = "https://api.imgbb.com/1/upload";
            String payload = "key=" + apiKey + "&image=" + URLEncoder.encode(base64Image, StandardCharsets.UTF_8);

            URL url = new URL(apiEndpoint);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.getOutputStream().write(payload.getBytes(StandardCharsets.UTF_8));

            // Read the API response
            InputStream responseStream = conn.getInputStream();
            String apiResponse = new String(responseStream.readAllBytes(), StandardCharsets.UTF_8);
            responseStream.close();

            JsonObject jsonResponse = new Gson().fromJson(apiResponse, JsonObject.class);

            String imageUrl = jsonResponse.getAsJsonObject("data").get("url").getAsString();

            User user = (User) request.getSession().getAttribute(SESSION_ACCOUNT_INFOMATION);
            user.setAvatar(imageUrl);

            UserDao.updateUser(user);
            HttpSession session = request.getSession(true);
            User userInfomation = UserDao.getInfoUserById(user.getId());
            session.setAttribute(SESSION_ACCOUNT_INFOMATION, userInfomation);

            // Redirect to the userProfile page
            response.sendRedirect(PROFILE_PAGE);
        } finally {
            fileInputStream.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
