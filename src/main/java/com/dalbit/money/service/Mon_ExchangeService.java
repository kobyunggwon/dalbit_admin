package com.dalbit.money.service;

import com.dalbit.common.code.Code;
import com.dalbit.common.code.Status;
import com.dalbit.common.service.SmsService;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.common.vo.SmsVo;
import com.dalbit.content.service.PushService;
import com.dalbit.content.vo.procedure.P_pushInsertVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.money.dao.Mon_ExchangeDao;
import com.dalbit.money.vo.Mon_EnableOutputVo;
import com.dalbit.money.vo.Mon_ExchangeInputVo;
import com.dalbit.money.vo.Mon_ExchangeOutputVo;
import com.dalbit.money.vo.procedure.P_ExchangeCancelInputVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Mon_ExchangeService {

    @Autowired
    Mon_ExchangeDao monExchangeDao;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    SmsService smsService;

    @Autowired
    PushService pushService;

    @Autowired
    Mem_MemberDao mem_MemberDao;

    public String selectExchangeList(Mon_ExchangeInputVo monExchangeInputVo){

        var resultMap = new HashMap<>();

        if(DalbitUtil.isEmpty(monExchangeInputVo.getIsSpecial())){  //환전가능리스트
            int enableCnt = monExchangeDao.selectEnableCnt(monExchangeInputVo);
            monExchangeInputVo.setTotalCnt(enableCnt);
            ArrayList<Mon_EnableOutputVo> enableList = monExchangeDao.selectEnableList(monExchangeInputVo);

            resultMap.put("enableCnt", enableCnt);
            resultMap.put("enableList", enableList);

        }else{  //환전내역
            int exchangeCnt = monExchangeDao.selectExchangeCnt(monExchangeInputVo);
            monExchangeInputVo.setTotalCnt(exchangeCnt);
            ArrayList<Mon_ExchangeOutputVo> exchangeList = monExchangeDao.selectExchangeList(monExchangeInputVo);

            for(int i=0;i<exchangeList.size();i++) {
                MemberVo outVo = mem_MemberDao.getMemberInfo(exchangeList.get(i).getMem_no());
                if(!DalbitUtil.isEmpty(outVo)) {
                    exchangeList.get(i).setMem_sex(outVo.getMem_sex());
                }
                // 테스트 아이디 등록 여부
                int testidCnt = monExchangeDao.testid_historyCnt(exchangeList.get(i).getMem_no());
                if(testidCnt > 0){
                    exchangeList.get(i).setTestid_history("Y");
                }else{
                    exchangeList.get(i).setTestid_history("N");
                }
            }

            resultMap.put("exchangeCnt", exchangeCnt);
            resultMap.put("exchangeList", exchangeList);
        }

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }

    public String selectExchangeSummary(Mon_ExchangeInputVo monExchangeInputVo){

        monExchangeInputVo.setIsSpecial(1);
        ArrayList<Integer> specialSummaryList = monExchangeDao.selectSummaryInfo(monExchangeInputVo);

        monExchangeInputVo.setIsSpecial(0);
        ArrayList<Integer> generalSummaryList = monExchangeDao.selectSummaryInfo(monExchangeInputVo);

        var resultMap = new HashMap<>();
        resultMap.put("specialSummaryList", specialSummaryList);
        resultMap.put("generalSummaryList", generalSummaryList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }

    public Model getListExcel(Mon_ExchangeInputVo monExchangeInputVo, Model model) {

        ArrayList<Mon_ExchangeOutputVo> exchangeList = monExchangeDao.selectExchangeList(monExchangeInputVo);

        String[] specialDj_headers = {
            "No", "아이디", "이름", "예금주", "금액",
            "스페셜DJ혜택", "과세금액", "소득세", "주민세", "수수료",
            "실지급액",  "주민번호", "연락처", "은행명", "계좌번호",
            "주소"
        };

        int[] specialDj_headerWidths = {
            1000, 4000, 3000, 3000, 3000,
            3000, 3000, 2000, 2000, 3000,
            4000, 3500, 3000, 5000, 10000,
            10000
        };

        String[] general_headers = {
                "No", "아이디", "이름", "예금주", "금액",
                /*"스페셜DJ혜택", "과세금액",*/ "소득세", "주민세", "수수료",
                "실지급액",  "주민번호", "연락처", "은행명", "계좌번호",
                "주소"
        };

        int[] general_headerWidths = {
                1000, 4000, 3000, 3000, 3000,
                /*3000, 3000,*/ 2000, 2000, 3000,
                4000, 3500, 3000, 5000, 10000,
                10000
        };

        int cashBasicTotal = 0;
        int benefitTotal = 0;
        int incomeTaxTotal = 0;
        int residentTaxTotal = 0;
        int transferFeeTotal = 0;
        int exchangeCashTotal = 0;

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < exchangeList.size(); i++){
            var exchangeVo = exchangeList.get(i);

            HashMap hm = new LinkedHashMap();

            hm.put("no", i+1);
            hm.put("id", DalbitUtil.isEmpty(exchangeVo.getMem_id()) ? "" : exchangeVo.getMem_id());
            hm.put("name", DalbitUtil.isEmpty(exchangeVo.getMem_name()) ? "" : exchangeVo.getMem_name());
            hm.put("accountName", DalbitUtil.isEmpty(exchangeVo.getAccount_name()) ? "" : exchangeVo.getAccount_name());

            hm.put("cashBasic", exchangeVo.getCash_basic());
            cashBasicTotal += exchangeVo.getCash_basic();

            if(monExchangeInputVo.getIsSpecial() == 1){
                hm.put("benefit", exchangeVo.getBenefit());
                benefitTotal += exchangeVo.getBenefit();

                hm.put("cashSum", exchangeVo.getCash_basic() + exchangeVo.getBenefit());
            }

            hm.put("income_tax", exchangeVo.getIncome_tax());
            incomeTaxTotal += exchangeVo.getIncome_tax();

            hm.put("resident_tax", exchangeVo.getResident_tax());
            residentTaxTotal += exchangeVo.getResident_tax();

            hm.put("transfer_fee", exchangeVo.getTransfer_fee());
            transferFeeTotal += exchangeVo.getTransfer_fee();

            hm.put("exchangeCash", exchangeVo.getCash_real());
            exchangeCashTotal += exchangeVo.getCash_real();

            hm.put("socialNo", DalbitUtil.isEmpty(exchangeVo.getSocial_no()) ? "" : DalbitUtil.convertJuminNo(exchangeVo.getSocial_no()));
            hm.put("phoneNo", DalbitUtil.isEmpty(exchangeVo.getPhone_no()) ? "" : DalbitUtil.convertPhoneNo(exchangeVo.getPhone_no()));

            hm.put("bankName", getBankName(exchangeVo.getBank_code()));
            hm.put("accountNo", DalbitUtil.isEmpty(exchangeVo.getAccount_no()) ? "" : exchangeVo.getAccount_no());

            String address = DalbitUtil.isEmpty(exchangeVo.getAddress_1()) ? "" : exchangeVo.getAddress_1();
            address += DalbitUtil.isEmpty(exchangeVo.getAddress_2()) ? "" : " "+ exchangeVo.getAddress_2();
            hm.put("address", address);

            bodies.add(hm.values().toArray());
        }

        if(0 < exchangeList.size()){
            HashMap totalMap = new LinkedHashMap();
            totalMap.put("no", "");
            totalMap.put("id", "합계");
            totalMap.put("name", "");
            totalMap.put("accountName", "");
            totalMap.put("cashBasic", cashBasicTotal);

            if(monExchangeInputVo.getIsSpecial() == 1) {
                totalMap.put("benefit", benefitTotal);
                totalMap.put("cashSum", cashBasicTotal + benefitTotal);
            }

            totalMap.put("income_tax", incomeTaxTotal);
            totalMap.put("resident_tax", residentTaxTotal);
            totalMap.put("transfer_fee", transferFeeTotal);
            totalMap.put("exchangeCash", exchangeCashTotal);
            totalMap.put("socialNo", "");
            totalMap.put("phoneNo", "");
            totalMap.put("bankName", "");
            totalMap.put("accountNo", "");
            totalMap.put("address", "");

            bodies.add(totalMap.values().toArray());
        }

        var excelVo = new ExcelVo();
        if(monExchangeInputVo.getIsSpecial() == 1){
            excelVo.setHeaders(specialDj_headers);
            excelVo.setHeaderWidths(specialDj_headerWidths);

        }else{
            excelVo.setHeaders(general_headers);
            excelVo.setHeaderWidths(general_headerWidths);
        }
        excelVo.setBodies(bodies);

        SXSSFWorkbook workbook = excelService.excelDownload("환전",excelVo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "환전 목록");
        model.addAttribute("listSize", exchangeList.size());
        model.addAttribute("body", excelVo.getBodies());

        return model;
    }

    public String getBankName(String bankCode){
        if (bankCode.equals("39")){
            return "경남은행";
        } else if (bankCode.equals("34")) {
            return "광주은행";
        } else if (bankCode.equals("4")) {
            return "국민은행";
        } else if (bankCode.equals("3")) {
            return "기업은행";
        } else if (bankCode.equals("11")) {
            return "농협";
        } else if (bankCode.equals("31")) {
            return "대구은행";
        } else if (bankCode.equals("55")) {
            return "도이치은행";
        } else if (bankCode.equals("32")) {
            return "부산은행";
        } else if (bankCode.equals("61")) {
            return "비엔피파리바은행";
        } else if (bankCode.equals("64")) {
            return "산림조합중앙회";
        } else if (bankCode.equals("2")) {
            return "산업은행";
        } else if (bankCode.equals("50")) {
            return "저축은행";
        } else if (bankCode.equals("45")) {
            return "새마을금고중앙회";
        } else if (bankCode.equals("8")) {
            return "수출입은행";
        } else if (bankCode.equals("7")) {
            return "수협은행";
        } else if (bankCode.equals("88")) {
            return "신한은행";
        } else if (bankCode.equals("48")) {
            return "신협";
        } else if (bankCode.equals("20")) {
            return "우리은행";
        } else if (bankCode.equals("71")) {
            return "우체국";
        } else if (bankCode.equals("37")) {
            return "전북은행";
        } else if (bankCode.equals("35")) {
            return "제주은행";
        } else if (bankCode.equals("67")) {
            return "중국건설은행";
        } else if (bankCode.equals("62")) {
            return "중국공상은행";
        } else if (bankCode.equals("90")) {
            return "카카오뱅크";
        } else if (bankCode.equals("89")) {
            return "케이뱅크";
        } else if (bankCode.equals("294")) {
            return "펀드온라인코리아";
        } else if (bankCode.equals("27")) {
            return "한국씨티은행";
        } else if (bankCode.equals("60")) {
            return "BOA은행";
        } else if (bankCode.equals("54")) {
            return "HSBC은행";
        } else if (bankCode.equals("57")) {
            return "제이피모간체이스은행";
        } else if (bankCode.equals("81")) {
            return "하나은행";
        } else if (bankCode.equals("23")) {
            return "SC제일은행";
        } else if (bankCode.equals("247")) {
            return "NH투자증권";
        } else if (bankCode.equals("261")) {
            return "교보증권";
        } else if (bankCode.equals("267")) {
            return "대신증권";
        } else if (bankCode.equals("287")) {
            return "메리츠종합금융증권";
        } else if (bankCode.equals("238")) {
            return "미래에셋대우";
        } else if (bankCode.equals("290")) {
            return "부국증권";
        } else if (bankCode.equals("240")) {
            return "삼성증권";
        } else if (bankCode.equals("291")) {
            return "신영증권";
        } else if (bankCode.equals("278")) {
            return "신한금융투자";
        } else if (bankCode.equals("209")) {
            return "유안타증권";
        } else if (bankCode.equals("280")) {
            return "유진투자증권";
        } else if (bankCode.equals("265")) {
            return "이베스트투자증권";
        } else if (bankCode.equals("292")) {
            return "케이프투자증권";
        } else if (bankCode.equals("264")) {
            return "키움증권";
        } else if (bankCode.equals("270")) {
            return "하나금융투자";
        } else if (bankCode.equals("262")) {
            return "하이투자증권";
        } else if (bankCode.equals("243")) {
            return "한국투자증권";
        } else if (bankCode.equals("269")) {
            return "한화투자증권";
        } else if (bankCode.equals("263")) {
            return "현대차증권";
        } else if (bankCode.equals("279")) {
            return "DB금융투자";
        } else if (bankCode.equals("218")) {
            return "KB증권";
        } else if (bankCode.equals("227")) {
            return "KTB투자증권";
        } else if (bankCode.equals("266")) {
            return "SK증권";
        } else {
            return bankCode;
        }

    }

    public String selectExchangeDetail(Mon_ExchangeInputVo monExchangeInputVo){

        Mon_ExchangeOutputVo monExchangeOutputVo = monExchangeDao.selectExchangeDetail(monExchangeInputVo);

        var resultMap = new HashMap<>();
        resultMap.put("detail", monExchangeOutputVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }

    public String updateExchangeDetail(Mon_ExchangeOutputVo monExchangeOutputVo){

        monExchangeDao.updateExchangeDetail(monExchangeOutputVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public String updateExchangeComplete(Mon_ExchangeOutputVo monExchangeOutputVo) throws GlobalException {

        monExchangeDao.updateExchangeComplete(monExchangeOutputVo);
        if(monExchangeOutputVo.getState().equals("1")) {
            var message = new StringBuffer();
            message.append("[달빛라이브] 회원님께서 신청하신 환전요청 건이 승인이 완료되어 요청금액이 입금되었습니다.");
            //message.append("\n\n※ 마이페이지>내지갑에서도 내역을 확인할 수 있습니다.");

            smsService.sendSms(new SmsVo(message.toString(), monExchangeOutputVo.getPhone_no(), Code.SMS발송_환전완료.getCode()));
            //smsService.sendMms(new SmsVo("[달빛라이브]", message.toString(), monExchangeOutputVo.getPhone_no(), Code.SMS발송_환전완료.getCode()));

            try{    // PUSH 발송

                var monExchangeInputVo = new Mon_ExchangeInputVo();
                monExchangeInputVo.setIdx(monExchangeOutputVo.getIdx());
                Mon_ExchangeOutputVo exchangeInfo = monExchangeDao.selectExchangeDetail(monExchangeInputVo);

                P_pushInsertVo pPushInsertVo = new P_pushInsertVo();
                pPushInsertVo.setMem_nos(exchangeInfo.getMem_no());
                pPushInsertVo.setSlct_push("2");
                pPushInsertVo.setSend_title("회원님께서 신청하신 환전처리가 완료되었습니다.");
                pPushInsertVo.setSend_cont("마이페이지 > 내지갑을 확인해주세요.");
                pPushInsertVo.setImage_type("101");
                pushService.sendPushReqOK(pPushInsertVo);
            }catch (Exception e){
                log.error("[PUSH 발송 실패 - 환전 성공]");
            }

        }else if(monExchangeOutputVo.getState().equals("2")){
            P_ExchangeCancelInputVo pExchangeCancelInputVo = new P_ExchangeCancelInputVo();
            pExchangeCancelInputVo.setExchangeIdx(monExchangeOutputVo.getIdx());
            var procedureVo = new ProcedureVo(pExchangeCancelInputVo);
            monExchangeDao.callExchangeCancel(procedureVo);

            if(procedureVo.getRet().equals(Status.환전_취소_없는환전번호.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.환전_취소_없는환전번호));

            }else if(procedureVo.getRet().equals(Status.환전_취소_취소상태아님.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.환전_취소_취소상태아님));

            }else if(procedureVo.getRet().equals(Status.환전_취소_회원번호없음.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.환전_취소_회원번호없음));

            }else if(procedureVo.getRet().equals(Status.환전_취소_이미완료.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.환전_취소_이미완료));
            }


            var message = new StringBuffer();
            message.append("[달빛라이브] 회원님께서 신청하신 환전요청 정보가 부적합하여 정상처리가 되지않았습니다.");
            //message.append("신청정보를 다시 확인하시고, 재신청하여 주시기 바랍니다.\n\n");
            //message.append("※ 궁금한 사항은 1:1문의로 연락해 주시기바랍니다.\n");

            smsService.sendSms(new SmsVo(message.toString(), monExchangeOutputVo.getPhone_no(), Code.SMS발송_환전불가.getCode()));
            //smsService.sendMms(new SmsVo("[달빛라이브]", message.toString(), monExchangeOutputVo.getPhone_no(), Code.SMS발송_환전불가.getCode()));

            try{    // PUSH 발송

                var monExchangeInputVo = new Mon_ExchangeInputVo();
                monExchangeInputVo.setIdx(monExchangeOutputVo.getIdx());
                Mon_ExchangeOutputVo exchangeInfo = monExchangeDao.selectExchangeDetail(monExchangeInputVo);

                P_pushInsertVo pPushInsertVo = new P_pushInsertVo();
                pPushInsertVo.setMem_nos(exchangeInfo.getMem_no());
                pPushInsertVo.setSlct_push("2");
                pPushInsertVo.setSend_title("환전신청이 승인되지 않았습니다.");
                pPushInsertVo.setSend_cont("신청하신 환전정보 중 첨부파일이 명확하게 확인되지 않아 승인이 거부되었습니다.");
                pPushInsertVo.setImage_type("101");
                pushService.sendPushReqOK(pPushInsertVo);
            }catch (Exception e){
                log.error("[PUSH 발송 실패 - 환전 불가]");
            }

        }

        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public String updateExchangeMultiComplete(Mon_ExchangeInputVo monExchangeInputVo){

        monExchangeDao.updateExchangeMultiComplete(monExchangeInputVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public List<Object[]> getExcelData(Mon_ExchangeInputVo monExchangeInputVo, Model model){
        ArrayList<Mon_ExchangeOutputVo> exchangeList = monExchangeDao.selectExchangeList(monExchangeInputVo);

        int cashBasicTotal = 0;
        int benefitTotal = 0;
        int incomeTaxTotal = 0;
        int residentTaxTotal = 0;
        int transferFeeTotal = 0;
        int exchangeCashTotal = 0;

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < exchangeList.size(); i++){
            var exchangeVo = exchangeList.get(i);

            HashMap hm = new LinkedHashMap();

            hm.put("no", i+1);
            hm.put("id", DalbitUtil.isEmpty(exchangeVo.getMem_id()) ? "" : exchangeVo.getMem_id());
            hm.put("name", DalbitUtil.isEmpty(exchangeVo.getMem_name()) ? "" : exchangeVo.getMem_name());
            hm.put("accountName", DalbitUtil.isEmpty(exchangeVo.getAccount_name()) ? "" : exchangeVo.getAccount_name());

            hm.put("cashBasic", exchangeVo.getCash_basic());
            cashBasicTotal += exchangeVo.getCash_basic();

            if(monExchangeInputVo.getIsSpecial() == 1){
                hm.put("benefit", exchangeVo.getBenefit());
                benefitTotal += exchangeVo.getBenefit();

                hm.put("cashSum", exchangeVo.getCash_basic() + exchangeVo.getBenefit());
            }

            hm.put("income_tax", exchangeVo.getIncome_tax());
            incomeTaxTotal += exchangeVo.getIncome_tax();

            hm.put("resident_tax", exchangeVo.getResident_tax());
            residentTaxTotal += exchangeVo.getResident_tax();

            hm.put("transfer_fee", exchangeVo.getTransfer_fee());
            transferFeeTotal += exchangeVo.getTransfer_fee();

            hm.put("exchangeCash", exchangeVo.getCash_real());
            exchangeCashTotal += exchangeVo.getCash_real();

            hm.put("socialNo", DalbitUtil.isEmpty(exchangeVo.getSocial_no()) ? "" : DalbitUtil.convertJuminNo(exchangeVo.getSocial_no()));
            hm.put("phoneNo", DalbitUtil.isEmpty(exchangeVo.getPhone_no()) ? "" : DalbitUtil.convertPhoneNo(exchangeVo.getPhone_no()));

            hm.put("bankName", getBankName(exchangeVo.getBank_code()));
            hm.put("accountNo", DalbitUtil.isEmpty(exchangeVo.getAccount_no()) ? "" : exchangeVo.getAccount_no());

            String address = DalbitUtil.isEmpty(exchangeVo.getAddress_1()) ? "" : exchangeVo.getAddress_1();
            address += DalbitUtil.isEmpty(exchangeVo.getAddress_2()) ? "" : " "+ exchangeVo.getAddress_2();
            hm.put("address", address);

            bodies.add(hm.values().toArray());
        }

        if(0 < exchangeList.size()){
            HashMap totalMap = new LinkedHashMap();
            totalMap.put("no", "");
            totalMap.put("id", "합계");
            totalMap.put("name", "");
            totalMap.put("accountName", "");
            totalMap.put("cashBasic", cashBasicTotal);

            if(monExchangeInputVo.getIsSpecial() == 1) {
                totalMap.put("benefit", benefitTotal);
                totalMap.put("cashSum", cashBasicTotal + benefitTotal);
            }

            totalMap.put("income_tax", incomeTaxTotal);
            totalMap.put("resident_tax", residentTaxTotal);
            totalMap.put("transfer_fee", transferFeeTotal);
            totalMap.put("exchangeCash", exchangeCashTotal);
            totalMap.put("socialNo", "");
            totalMap.put("phoneNo", "");
            totalMap.put("bankName", "");
            totalMap.put("accountNo", "");
            totalMap.put("address", "");

            bodies.add(totalMap.values().toArray());
        }

        return bodies;
    }
}
