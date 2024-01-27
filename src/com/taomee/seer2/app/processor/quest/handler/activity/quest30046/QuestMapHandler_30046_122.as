package com.taomee.seer2.app.processor.quest.handler.activity.quest30046 {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30046_122 extends QuestMapHandler {


    private var _server:ServerBuffer;

    private var _count:int;

    private var _itemList:Vector.<Sprite>;

    public function QuestMapHandler_30046_122(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            ServerBufferManager.getServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL, this.getServerData);
        }
    }

    private function getServerData(param1:ServerBuffer):void {
        var _loc2_:Sprite = null;
        this._server = param1;
        this._count = param1.readDataAtPostion(1);
        if (this._count < 2) {
            this._itemList = new Vector.<Sprite>();
            this._itemList.push(_processor.resLib.getSprite("item0"));
            this._itemList.push(_processor.resLib.getSprite("item1"));
            SceneManager.active.mapModel.content.addChild(this._itemList[0]);
            SceneManager.active.mapModel.content.addChild(this._itemList[1]);
            for each(_loc2_ in this._itemList) {
                _loc2_.buttonMode = true;
                _loc2_.addEventListener(MouseEvent.CLICK, this.onCLick);
            }
        }
    }

    private function onCLick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        DisplayUtil.removeForParent(e.currentTarget as DisplayObject);
        if (this._count < 2) {
            this._count += 1;
            ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL, 1, this._count);
            ServerMessager.addMessage("恭喜你获得了一个器材");
            if (this._count >= 2 && this._server.readDataAtPostion(2) >= 2 && this._server.readDataAtPostion(3) >= 2) {
                if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
                    QuestManager.completeStep(_quest.id, 1);
                }
                AlertManager.showAlert("恭喜你搜集齐所有的材料", function ():void {
                    ModuleManager.toggleModule(URLUtil.getAppModule("MakeBattleSuitPanel"), "");
                });
            } else if (this._count >= 2) {
                DisplayUtil.removeForParent(this._itemList[0]);
                DisplayUtil.removeForParent(this._itemList[1]);
                ModuleManager.toggleModule(URLUtil.getAppModule("MakeSuitTwoPanel"), "");
            }
        }
    }

    override public function processMapDispose():void {
        if (Boolean(this._itemList) && this._itemList.length >= 2) {
            DisplayUtil.removeForParent(this._itemList[0]);
            DisplayUtil.removeForParent(this._itemList[1]);
        }
    }
}
}
