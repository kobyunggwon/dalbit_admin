package com.dalbit.broadcast.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoryVo {

    /*  intput  */
    private String roomNo;

    /* return result */
    private String memNo;
    private String memId;
    private String memNick;
    private String status;
    private String writeDate;
    private String story;

}