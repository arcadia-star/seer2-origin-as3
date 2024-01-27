package com.taomee.seer2.app.notify.data.notice {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.team.TeamManager;
import com.taomee.seer2.app.team.data.TeamMainInfo;

public class TeamNotice extends Notice {

    private static const INVITE:uint = 1084;

    private static const APPLY:uint = 1166;

    private static const REJECT:uint = 1571;


    private var _commandId:uint;

    private var _teamInfo:TeamMainInfo;

    private var _nick:String;

    private var _extraData:uint;

    private var _userID:int;

    public function TeamNotice(param1:uint, param2:uint, param3:TeamMainInfo, param4:String, param5:uint) {
        super(NoticeType.TEAM, param2);
        this._teamInfo = param3;
        this._nick = param4;
        this._commandId = param1;
        this._extraData = param5;
        this._userID = param2;
    }

    override public function process():void {
        switch (this._commandId) {
            case INVITE:
                AlertManager.showTeamCommonAlert("【" + this._nick + "】 邀请你加入" + this._teamInfo.name + "战队", this._teamInfo, this.onConfirmInvite, this.onCancelInvite);
                break;
            case APPLY:
                AlertManager.showTeamApplyAlert(this._extraData + "_" + this._nick + "_" + this._userID, this._teamInfo, this.onConfirmApply, this.onCancelApply);
                break;
            case REJECT:
                ServerMessager.addMessage("很抱歉！对方拒绝了你的请求！原因是：" + this._teamInfo.msg);
        }
    }

    private function onConfirmInvite():void {
        TeamManager.replyInviteTeam(userId, this._teamInfo.id, 1, this.onJoinSuccess);
    }

    private function onCancelInvite():void {
        TeamManager.replyInviteTeam(userId, this._teamInfo.id, 0);
    }

    private function onJoinSuccess():void {
        TeamManager.teamInfo.changeBaseInfo(this._teamInfo);
    }

    private function onConfirmApply():void {
        TeamManager.inviteTeam(userId);
    }

    private function onCancelApply(param1:String = ""):void {
        TeamManager.rejectJoinTeam(userId, param1);
    }
}
}
