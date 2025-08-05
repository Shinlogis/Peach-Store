package peachstore.admin.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.Map;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.OrderReceipt;
import peachstore.domain.Tosspayment;
import peachstore.dto.ConfirmPaymentRequest;
import peachstore.dto.TossConfirmResponse;
import peachstore.repository.tosspayment.TosspaymentDAO;
import peachstore.service.TossPaymentService;
import peachstore.service.orderreceipt.OrderReceiptService;

@Slf4j
@RequiredArgsConstructor
@Controller
public class PaymentController {
}
