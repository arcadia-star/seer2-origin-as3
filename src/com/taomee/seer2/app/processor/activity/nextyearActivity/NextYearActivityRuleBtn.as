package com.taomee.seer2.app.processor.activity.nextyearActivity {
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.tipSkins.CommonTipSkin;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.Tick;

public class NextYearActivityRuleBtn {

    private static const FU_ZHOU_ID:int = 400239;

    private static const FU_WEN_ID:int = 400240;

    private static var _instance:NextYearActivityRuleBtn;


    private var _btn:SimpleButton;

    private var _btnTips:CommonTipSkin;

    private var _itemTips:CommonTipSkin;

    public function NextYearActivityRuleBtn() {
        super();
        this._btn = UIManager.getButton("UI_NextYearActivity");
        this._btn.x = 900;
        this._btn.y = 90;
    }

    public static function get instance():NextYearActivityRuleBtn {
        if (_instance == null) {
            _instance = new NextYearActivityRuleBtn();
        }
        return _instance;
    }

    public function show():void {
        LayerManager.uiLayer.addChild(this._btn);
        this._btn.addEventListener(MouseEvent.CLICK, this.onBtnClick);
        ServerBufferManager.getServerBuffer(ServerBufferType.TI_DENG_GUAI, this.onGetTiDengServerBuffer);
    }

    public function hide():void {
        DisplayObjectUtil.removeFromParent(this._btn);
        this.removeBtnEventListener();
    }

    private function onGetTiDengServerBuffer(param1:ServerBuffer):void {
        var _loc2_:int = param1.readDataAtPostion(0);
        if (_loc2_ == 1) {
            this.addBtnEventListener();
        } else {
            this._btnTips = new CommonTipSkin();
            this._btnTips.x = this._btn.x - 80;
            this._btnTips.y = this._btn.y;
            this._btnTips.isFlip = true;
            this._btnTips.show("哟呼！快打开看看！");
            Tick.instance.addTimeout(10000, this.onBtnTipsEnd);
            ServerBufferManager.updateServerBuffer(ServerBufferType.TI_DENG_GUAI, 0, 1);
        }
    }

    private function onBtnTipsEnd():void {
        DisplayObjectUtil.removeFromParent(this._btnTips);
        this.addBtnEventListener();
    }

    private function addBtnEventListener():void {
        this._btn.addEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOver);
        this._btn.addEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOut);
        this._btn.addEventListener(MouseEvent.CLICK, this.onBtnClick);
    }

    private function removeBtnEventListener():void {
        this._btn.removeEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOver);
        this._btn.removeEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOut);
        this._btn.removeEventListener(MouseEvent.CLICK, this.onBtnClick);
    }

    private function onBtnRollOver(param1:MouseEvent):void {
        ItemManager.addEventListener1(ItemEvent.REQUEST_ITEM_SUCCESS, this.onRequestItemSucc);
        ItemManager.requestItemList(null);
    }

    private function onBtnRollOut(param1:MouseEvent):void {
        ItemManager.removeEventListener1(ItemEvent.REQUEST_ITEM_SUCCESS, this.onRequestItemSucc);
        DisplayObjectUtil.removeFromParent(this._itemTips);
    }

    private function onBtnClick(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("TiDengGuaiDescriptionPanel"), "正在打开新年礼物规则面板...");
    }

    private function onRequestItemSucc(param1:ItemEvent):void {
        ItemManager.removeEventListener1(ItemEvent.REQUEST_ITEM_SUCCESS, this.onRequestItemSucc);
        var _loc2_:int = ItemManager.getItemQuantityByReferenceId(FU_WEN_ID);
        var _loc3_:int = ItemManager.getItemQuantityByReferenceId(FU_ZHOU_ID);
        var _loc4_:* = "尼古福文  " + _loc2_ + "个\n尼古福咒  " + _loc3_ + "个";
        if (this._itemTips == null) {
            this._itemTips = new CommonTipSkin();
            this._itemTips.x = this._btn.x - 60;
            this._itemTips.y = this._btn.y;
            this._itemTips.isFlip = true;
        }
        this._itemTips.show(_loc4_);
    }
}
}
