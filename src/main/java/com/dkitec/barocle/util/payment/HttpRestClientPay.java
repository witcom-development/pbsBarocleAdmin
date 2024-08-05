package com.dkitec.barocle.util.payment;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;

@SuppressWarnings("deprecation")
public class HttpRestClientPay {
	public static String connect(String reqUrl, String reqParams){
		
		@SuppressWarnings("resource")
		HttpClient httpClient;
		StringBuffer result = new StringBuffer();
		
		try {
			HttpPost postRequest = new HttpPost(reqUrl);
			
			if(postRequest.getURI().getScheme().toUpperCase().equals("HTTPS")) {
				SSLContext sslcontext = SSLContexts.custom().loadTrustMaterial(null, new TrustStrategy() {
					public boolean isTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
						return true;
					}
				}).build();
			
				SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
					sslcontext,
					new String[] { "TLSv1" },
					null,
					SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER
	//				SSLConnectionSocketFactory.getDefaultHostnameVerifier()
				);
				httpClient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
			} else {
				httpClient = new DefaultHttpClient();
			}
			
			StringEntity input = new StringEntity(reqParams, "UTF-8");
			
			System.out.println(reqParams);
			postRequest.setHeader("Accept", "application/json");
			postRequest.setHeader("Content-type", "application/json;charset=UTF-8");
			postRequest.setEntity(input);
			
			// Execute HTTP request
			HttpResponse response = httpClient.execute(postRequest);
			System.out.println(response.getStatusLine());
			
			BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent())));
			String output;
			while ((output = br.readLine()) != null) {
				result.append(output);
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e){
			e.printStackTrace();
		}
		return result.toString();
	}
}