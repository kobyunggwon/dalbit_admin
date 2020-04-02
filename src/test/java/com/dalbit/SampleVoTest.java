/*
package com.dalbit;

import com.dalbit.common.service.CommonService;
import com.dalbit.common.service.SmsService;
import com.dalbit.common.vo.CodeVo;
import com.dalbit.common.vo.CookieVo;
import com.dalbit.common.vo.SmsVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.inforex.vo.InforexPosCode;
import com.dalbit.socket.service.SocketService;
import com.dalbit.util.JwtUtil;
import com.dalbit.util.OkHttpClientUtil;
import com.dalbit.util.RestApiUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import okhttp3.FormBody;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.HashMap;
import java.util.List;

@Slf4j
@SpringBootTest
@ActiveProfiles({"local"})
public class SampleVoTest {

    @Autowired
    CommonService commonService;
    @Autowired
    RestApiUtil restApiUtil;
    @Autowired
    SocketService socketService;
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    SmsService smsService;


    @Test
    public void 공통코드조회(){
        List<CodeVo> codeVoList = commonService.getCodeList("subject_type");
        log.info("공통코드 : {}", codeVoList);

        //commonService.getCodeList("subject_type");
    }

    @Test
    public void 인포렉스로그인()throws Exception{

        RequestBody formBody = new FormBody.Builder()
            .add("userid", "leejaeho1144")
            .add("password", "20706wogh!")
            .add("mode", "login")
            .add("where", "dalbit")
        .build();

        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        Response response = okHttpClientUtil.sendPost("http://admin.inforex.co.kr/loginout.html", null);

        response.headers().toMultimap().get("set-cookie").stream().forEach(cookie ->{
            log.info("cookie info : {}", cookie);
        });
        log.info("data : {}", response.body().string());
    }

    @Test
    public void 인포렉스메뉴가져오기()throws Exception{

        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        String result = okHttpClientUtil.sendGet("http://admin.inforex.co.kr/dalbit/getCommonMenu.php", null,"", "");
        log.info(result);
    }

    @Test
    public void 쿠키파싱하기(){
        String cookieString = "ADMIN_COOKIE=eJw9jtkNgzAMhnfxBAkEEGYYZAnTQ80hQqRWVafpIjzy0D26RmMU9cmf%2F8MyYYfPiC0C2zA6D0PEBkH3qqmEDYIjy4I5s3227%2F4uS4q8XCZZdIVwY74Sn73WxohWI0S%2BHy6CPabKwC6Np8WnIEqu1Z1AX5z1Ebh88A%2Fp3I8rzXPu0cTlooLh9QOpVzph; path=/; domain=.inforex.co.kr";
        String[] cookieGubun = cookieString.split(";");
        CookieVo cookieVo = new CookieVo();

        for (String cookieSlice : cookieGubun) {
            String[] temp = cookieSlice.split("=");
            if(temp[0].trim().equals("path")){
                cookieVo.setPath(temp[1]);
            }else if(temp[0].trim().equals("domain")){
                cookieVo.setDomain(temp[1]);
            }else{
                cookieVo.setKey(temp[0]);
                cookieVo.setValue(temp[1]);
            }
        }

        log.info(cookieVo.toString());

    }

    @Test
    public void API서버콜테스트() throws GlobalException {
        RequestBody formBody = new FormBody.Builder()
                .add("userid", "leejaeho1144")
                .add("mode", "login")
                .add("where", "dalbit")
                .build();

        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        Response response = okHttpClientUtil.sendPost("https://devm-hwlee.dalbitlive.com:4431/self/auth/res", formBody);
    }

    @Test
    public void 메뉴테스트()throws Exception{
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        Response response = okHttpClientUtil.sendGet("http://admin.inforex.co.kr/dalbit/getCommonMenu.php");
    }

    @Test
    public void 직급코드()throws Exception{
        String result = RestApiUtil.sendGet("http://admin.inforex.co.kr/dalbit/getPosCodeList.php");

        InforexPosCode[] inforexPosCodes = new Gson().fromJson(result, InforexPosCode[].class);
        log.info("결과 : {}", inforexPosCodes);
        log.info("파싱 결과 : {}", inforexPosCodes);
    }
    @Test
    public void 소켓테스트()throws Exception{

        log.info("@@@@@@@@@@@@@@@@  1");
        socketService.kickout("91585616496431","11584406236831","11583120797169",jwtUtil.generateToken("11584406236831", true),true);

        log.info("@@@@@@@@@@@@@@@@  2");
    }

    @Test
    public void 문자발송테스트(){
        smsService.sendSms(new SmsVo("[제목]테스트입니다", "[내용]내용이에요 안드로이드는 제목이 보이죠?", "01073041558"));
    }

}
*/
