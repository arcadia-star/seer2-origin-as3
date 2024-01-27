package com.taomee.seer2.app.activity.summoned {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.StringConstants;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.StringUtil;

public class Summoned {

    private static var _stateFlag:uint = ActorManager.actorInfo.stateFlag;


    private var _badiMobile:Mobile;

    private var _duoluoMobile:Mobile;

    private var _container:Sprite;

    private var _passwordTxt:TextField;

    private var _confirmBtn:SimpleButton;

    public function Summoned(param1:Mobile, param2:Mobile) {
        super();
        this._badiMobile = param1;
        this._badiMobile.buttonMode = true;
        this._duoluoMobile = param2;
        this._duoluoMobile.buttonMode = true;
        this.initEventListener();
    }

    private function initEventListener():void {
        this._badiMobile.addEventListener(MouseEvent.CLICK, this.summonedBadi);
        this._duoluoMobile.addEventListener(MouseEvent.CLICK, this.summonedDuoluo);
    }

    private function summonedBadi(param1:MouseEvent):void {
        var _loc2_:XML = null;
        var _loc3_:DialogDefinition = null;
        if (_stateFlag != 0) {
            _loc2_ = new XML("<dialog npcId=\"10\" npcName=\"巴蒂\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[赛尔号Ⅱ召集令，召集伙伴，加入你我！快去召集伙伴，让他们到多罗那里填入你的米米号，并帮助他们提升到30级，神秘精灵就是你的啦。]]></node>" + "<reply action=\"close\" params=\"yesBadiDialog\"><![CDATA[查看我的召集令]]></reply>" + "<reply action=\"close\"><![CDATA[一会儿再来]]></reply></branch>" + "</dialog>");
            _loc3_ = new DialogDefinition(_loc2_);
            DialogPanel.addCloseEventListener(this.yesCheck);
            DialogPanel.showForCommon(_loc3_);
        } else {
            _loc2_ = new XML("<dialog npcId=\"10\" npcName=\"巴蒂\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[赛尔号Ⅱ召集令活动开始咯！这位兄台如果你的精灵最高等级<font color=\"#ff0000\">大于30级</font>,那么就可以在我这里登记米米号并召集小伙伴啦！更有超超超神秘大礼……]]></node>" + "<reply action=\"close\" params=\"noBadiDialog\"><![CDATA[登记我的米米号]]></reply>" + "<reply action=\"close\"><![CDATA[一会儿再来]]></reply></branch>" + "</dialog>");
            _loc3_ = new DialogDefinition(_loc2_);
            DialogPanel.addCloseEventListener(this.yesCheck);
            DialogPanel.showForCommon(_loc3_);
        }
    }

    private function summonedDuoluo(param1:MouseEvent):void {
        var _loc2_:XML = null;
        var _loc3_:DialogDefinition = null;
        if (ActorManager.actorInfo.callerUserId != 0) {
            _loc2_ = new XML("<dialog npcId=\"11\" npcName=\"多罗\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[赛尔号Ⅱ召集令，响应伙伴的召集，一同迈上探险阿卡迪亚星的奇妙之旅。输入召集你的伙伴的米米号，领取召集大礼包。]]></node>" + "<reply action=\"close\" params=\"yesDuoluoDialog\"><![CDATA[领取升级奖励]]></reply>" + "<reply action=\"close\"><![CDATA[一会儿再说]]></reply></branch>" + "</dialog>");
            _loc3_ = new DialogDefinition(_loc2_);
            DialogPanel.addCloseEventListener(this.yesCheck);
            DialogPanel.showForCommon(_loc3_);
        } else {
            _loc2_ = new XML("<dialog npcId=\"11\" npcName=\"多罗\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[哇哦！你好有眼力哦！你竟然选择加入赛尔Ⅱ！阿卡迪亚星的奇妙之旅正等着你呢！哦对了！输入召集你的小伙伴的米米号，马上领取召集大礼包。]]></node>" + "<reply action=\"close\" params=\"noDuoluoDialog\"><![CDATA[填入米米号]]></reply>" + "<reply action=\"close\"><![CDATA[一会儿再说]]></reply></branch>" + "</dialog>");
            _loc3_ = new DialogDefinition(_loc2_);
            DialogPanel.addCloseEventListener(this.yesCheck);
            DialogPanel.showForCommon(_loc3_);
        }
    }

    private function yesCheck(param1:DialogCloseEvent):void {
        if (param1.params == "yesBadiDialog") {
            ModuleManager.toggleModule(URLUtil.getAppModule("SummonedPanel"), "正在打开召集令面板...");
            DialogPanel.removeCloseEventListener(this.yesCheck);
        }
        if (param1.params == "yesDuoluoDialog") {
            ModuleManager.toggleModule(URLUtil.getAppModule("UpLevelRewardPanel"), "正在打开升级奖励面板...");
            DialogPanel.removeCloseEventListener(this.yesCheck);
        }
        if (param1.params == "noBadiDialog") {
            this.noCheck();
            DialogPanel.removeCloseEventListener(this.yesCheck);
        }
        if (param1.params == "noDuoluoDialog") {
            if (ActorManager.actorInfo.highestPetLevel > 10) {
                DialogPanel.showForSimple(11, "多罗", [[0, "羞羞羞……都已经这么高级了还要来领取新手召集大礼包哦！"]], "再见！");
                DialogPanel.removeCloseEventListener(this.yesCheck);
            } else {
                this.initActivityUI();
            }
        }
    }

    private function initActivityUI():void {
        this._container = UIManager.getSprite("UI_SeerMovieActivityTwoUI");
        LayerManager.dialogLayer.addChild(this._container);
        this._passwordTxt = this._container.getChildByName("passwordTxt") as TextField;
        this._passwordTxt.type = TextFieldType.INPUT;
        this._passwordTxt.restrict = "0-9";
        this._confirmBtn = this._container.getChildByName("confirmBtn") as SimpleButton;
        this._passwordTxt.addEventListener(Event.CHANGE, this.onPasswordChange);
        this._container["activation"].gotoAndStop(2);
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onSend);
        this._passwordTxt.text = "";
        this._confirmBtn.visible = false;
        DialogPanel.hide();
        DialogPanel.showForSimple(11, "多罗", [[0, "填入伙伴的米米号，大礼包在等着你，要仔细，不要填错了。"]], "等等再说", null, this._container);
    }

    private function noCheck():void {
        if (ActorManager.actorInfo.highestPetLevel > 30) {
            Connection.addErrorHandler(CommandSet.SET_THIS_SUMMONED_1076, this.onSetThisSummonedError);
            Connection.send(CommandSet.SET_THIS_SUMMONED_1076);
            _stateFlag = 100;
            DialogPanel.showForSimple(10, "巴蒂", [[0, "不得了！你一看就是资质过人！现在你已经成功完成登记啦，告诉你邀请的小伙伴让他到多罗那里填入你的米米号吧。"]], "好的", this.summonedBadiComplete);
        } else {
            DialogPanel.showForSimple(10, "巴蒂", [[0, "啧啧啧……你的精灵最高等级还没到30级别吧？要不再去练练？"]], "我回去再练练");
        }
    }

    private function summonedBadiComplete():void {
        AlertManager.showAlert("登记招募官成功");
    }

    private function onSetThisSummonedError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.SET_THIS_SUMMONED_1076, this.onSetThisSummonedError);
        if (param1.message.statusCode == 88) {
            AlertManager.showAlert("最高等级的精灵的等级不够");
        }
        if (param1.message.statusCode == 107) {
            AlertManager.showAlert("已经是召集者");
        }
    }

    private function onPasswordChange(param1:Event):void {
        if (StringUtil.trim(this._passwordTxt.text) == StringConstants.EMPTY) {
            this._confirmBtn.visible = false;
        } else {
            this._confirmBtn.visible = true;
        }
    }

    private function onSend(param1:MouseEvent):void {
        Connection.addErrorHandler(CommandSet.SET_SUMMONED_ID_1077, this.onSetSummonedIDError);
        Connection.addCommandListener(CommandSet.SET_SUMMONED_ID_1077, this.onSetSummonedID);
        Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onRequestSwap);
        var _loc2_:uint = uint(this._passwordTxt.text);
        Connection.send(CommandSet.SET_SUMMONED_ID_1077, _loc2_);
    }

    private function onSetSummonedID(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.SET_SUMMONED_ID_1077, this.onSetSummonedIDError);
        Connection.removeCommandListener(CommandSet.SET_SUMMONED_ID_1077, this.onSetSummonedID);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = ActorManager.actorInfo.callerUserId;
        _loc3_ = ActorManager.actorInfo.id;
        ActorManager.actorInfo.callerUserId = 1;
        DialogPanel.hide();
        AlertManager.showAlert("登记新船员成功");
        this._container = null;
    }

    private function onSetSummonedIDError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.SET_SUMMONED_ID_1077, this.onSetSummonedIDError);
        Connection.removeCommandListener(CommandSet.SET_SUMMONED_ID_1077, this.onSetSummonedID);
        var _loc2_:uint = uint(param1.message.statusCode);
        if (_loc2_ == 104356) {
            AlertManager.showAlert("召集人数超过上限20人");
        }
        if (_loc2_ == 104357) {
            AlertManager.showAlert("没有召集资格");
        }
        if (_loc2_ == 101105) {
            AlertManager.showAlert("没有此米米号");
        }
        if (_loc2_ == 110) {
            AlertManager.showAlert("精灵等级高于10级");
        }
        DialogPanel.hide();
        this._container = null;
    }

    private function onRequestSwap(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onRequestSwap);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:SwapInfo = new SwapInfo(_loc2_);
    }

    public function dispostContainer():void {
        if (this._container) {
            Connection.removeErrorHandler(CommandSet.SET_SUMMONED_ID_1077, this.onSetSummonedIDError);
            Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onRequestSwap);
            Connection.removeCommandListener(CommandSet.SET_SUMMONED_ID_1077, this.onSetSummonedID);
            this._passwordTxt.removeEventListener(Event.CHANGE, this.onPasswordChange);
            this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onSend);
            DisplayUtil.removeForParent(this._container);
            this._passwordTxt = null;
            this._confirmBtn = null;
            this._container = null;
        }
    }
}
}
