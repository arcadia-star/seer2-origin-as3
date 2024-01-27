package com.taomee.seer2.app.processor.quest.handler.activity.quest30042 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30042_240 extends QuestMapHandler {


    private var _itemList:Vector.<MovieClip>;

    private var _item0:MovieClip;

    private var _item1:MovieClip;

    private var _count:uint;

    private var _server:ServerBuffer;

    public function QuestMapHandler_30042_240(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            ServerBufferManager.getServerBuffer(ServerBufferType.OPEN_SCROOL, this.onGerServer);
        }
    }

    private function onGerServer(param1:ServerBuffer):void {
        var _loc2_:MovieClip = null;
        this._server = param1;
        this._count = param1.readDataAtPostion(3);
        if (this._count < 2) {
            this._itemList = Vector.<MovieClip>([]);
            this._itemList.push(_processor.resLib.getMovieClip("item4"));
            this._itemList.push(_processor.resLib.getMovieClip("item5"));
            SceneManager.active.mapModel.content.addChild(this._itemList[0]);
            SceneManager.active.mapModel.content.addChild(this._itemList[1]);
            for each(_loc2_ in this._itemList) {
                _loc2_.buttonMode = true;
                _loc2_.addEventListener(MouseEvent.CLICK, this.onItem);
            }
        }
    }

    private function onItem(param1:MouseEvent):void {
        var data:Object = null;
        var event:MouseEvent = param1;
        DisplayUtil.removeForParent(event.currentTarget as MovieClip);
        if (this._count < 2) {
            ++this._count;
            ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL, 3, this._count);
            ServerMessager.addMessage("获得1个收集品");
            if (this._count >= 2 && this._server.readDataAtPostion(1) >= 2 && this._server.readDataAtPostion(2) >= 2) {
                if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
                    QuestManager.completeStep(_quest.id, 1);
                }
                NpcDialog.show(113, "NONO", [[0, "风真大，还好没刮的太远，总算把东西找齐了，主人我们现在返回传送室吧。"]], ["嗯！我们回去吧！"], [function ():void {
                    SceneManager.changeScene(SceneType.LOBBY, 70);
                }]);
            } else if (this._count >= 2) {
                DisplayUtil.removeForParent(this._itemList[0]);
                DisplayUtil.removeForParent(this._itemList[1]);
                data = new Object();
                data.index = 1;
                ModuleManager.toggleModule(URLUtil.getAppModule("OpenSchoolPanel"), "正在打开面板...", data);
            }
        }
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._itemList[0]);
        DisplayUtil.removeForParent(this._itemList[1]);
    }
}
}
