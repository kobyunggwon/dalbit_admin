package com.dalbit.sample.dao;

import com.dalbit.sample.vo.ErrorVo;
import com.dalbit.sample.vo.SampleVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SampleDao {

    int getCount();
    List<SampleVo> getList();
    int insertSample(SampleVo sampleVo);
    List<ErrorVo> getLogErrorData(ErrorVo errorVo);
    int getLogErrorDataCnt(ErrorVo errorVo);
}
