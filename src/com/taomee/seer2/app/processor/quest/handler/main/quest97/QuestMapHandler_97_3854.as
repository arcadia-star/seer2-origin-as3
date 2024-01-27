package com.taomee.seer2.app.processor.quest.handler.main.quest97 {
import com.greensock.TweenNano;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_97_3854 extends QuestMapHandler {


    private var _mouse:MouseClickHintSprite;

    private var _gameUI:MovieClip;

    private var _fireMcList:Vector.<MovieClip>;

    private var _cameraMc:MovieClip;

    private var _maskMc:MovieClip;

    private var _oldNpc:Mobile;

    private var _newNpc:Mobile;

    public function QuestMapHandler_97_3854(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false) {
            RightToolbarConter.instance.hide();
            if (QuestManager.isStepComplete(questID, 2) == false) {
                this.initGame();
            }
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "97_2") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            SceneManager.changeScene(SceneType.LOBBY, 20);
        }
    }

    private function changeNpc(param1:uint):void {
        this._oldNpc = MobileManager.getMobile(param1, MobileType.NPC);
        this._oldNpc.visible = false;
        this._newNpc = new Mobile();
        this._newNpc.width = this._oldNpc.width;
        this._newNpc.height = this._oldNpc.height;
        this._newNpc.label = this._oldNpc.label;
        this._newNpc.setPostion(new Point(this._oldNpc.x, this._oldNpc.y));
        this._newNpc.resourceUrl = this._oldNpc.resourceUrl;
        this._newNpc.buttonMode = true;
        if (this._mouse == null) {
            this._mouse = new MouseClickHintSprite();
        }
        this._mouse.x = (this._newNpc.width - this._mouse.width) / 2;
        this._mouse.y = -this._mouse.height - 50;
        this._newNpc.addChild(this._mouse);
        MobileManager.addMobile(this._newNpc, MobileType.NPC);
        this._newNpc.addEventListener(MouseEvent.CLICK, this.onClickNpc);
    }

    private function afterFinish():void {
        if (this._newNpc) {
            this._newNpc.removeEventListener(MouseEvent.CLICK, this.onClickNpc);
            DisplayUtil.removeForParent(this._newNpc);
            this._newNpc = null;
        }
        if (this._oldNpc) {
            this._oldNpc.visible = true;
        }
    }

    private function onClickNpc(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(3020, "费雷德", [[0, "这！~~~~撒莱尔~~~真的不见了？！！！！这！~~~~撒莱尔~~~真的不见了？！！！！"]], ["撒莱尔是谁？"], [function ():void {
            NpcDialog.show(3020, "费雷德", [[0, "他是从黑暗法典中召唤出来的超强大精灵，从我们有历史记载起就守护者法典！现在法典遗失，撒莱尔也同样消失了！"]], ["这可怎么办？"], [function ():void {
                NpcDialog.show(3020, "费雷德", [[0, "既然他是从法典中召唤出来的，或许这页残页会有一些线索，看来只能想办法破解其中的奥秘了。"]], ["你难道不知道里面写了些什么吗？"], [function ():void {
                    NpcDialog.show(3020, "费雷德", [[0, "暗影法典只有影灵兽才能读懂，我们只是遵照他的旨意行事，但现在的影灵兽……"]], ["影灵兽怎么了？"], [function ():void {
                        NpcDialog.show(3020, "费雷德", [[0, "说来话长，但现在的影灵兽并不是他真正的本体，这本法典或许只能靠你们了"]], ["我可以去飞船上问问博士！"], [function ():void {
                            QuestManager.completeStep(questID, 2);
                            SceneManager.changeScene(SceneType.LOBBY, 20);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initGame():void {
        MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("findFireGameUI"), function callBack(param1:MovieClip):void {
            _gameUI = param1;
            _map.front.addChild(_gameUI);
            _fireMcList = new Vector.<MovieClip>();
            var _loc2_:int = 0;
            _loc2_ = 0;
            while (_loc2_ < 5) {
                _fireMcList.push(_gameUI["front_mc"]["fireMc" + _loc2_]);
                _loc2_++;
            }
            _cameraMc = _gameUI["front_mc"]["cameraMc"];
            _maskMc = _gameUI["front_mc"]["maskMc"];
            initGameEvent();
        });
    }

    private function onFireClick(param1:MouseEvent):void {
        var index:int;
        var evt:MouseEvent = param1;
        var i:int = 0;
        i = 0;
        while (i < this._fireMcList.length) {
            this._fireMcList[i].removeEventListener(MouseEvent.CLICK, this.onFireClick);
            i++;
        }
        index = this._fireMcList.indexOf(evt.currentTarget as MovieClip);
        if (-1 != index) {
            DisplayObjectUtil.removeFromParent(this._cameraMc.parent);
            TweenNano.delayedCall(1, function onComplete():void {
                changeNpc(3020);
                DisplayObjectUtil.removeFromParent(_gameUI);
                QuestManager.completeStep(questID, 1);
            });
        }
    }

    private function moveCamera(param1:MouseEvent):void {
        if (this._cameraMc == null) {
            return;
        }
        this._cameraMc.x = this._maskMc.x = param1.stageX;
        this._cameraMc.y = this._maskMc.y = param1.stageY;
    }

    private function initGameEvent():void {
        var i:int;
        if (_map.content.stage == null) {
            TweenNano.delayedCall(1, function ():void {
                _map.content.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveCamera);
            });
        } else {
            _map.content.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.moveCamera);
        }
        this._cameraMc.mouseEnabled = this._cameraMc.mouseChildren = false;
        i = 0;
        i = 0;
        while (i < this._fireMcList.length) {
            this._fireMcList[i].addEventListener(MouseEvent.CLICK, this.onFireClick);
            i++;
        }
    }

    override public function processMapDispose():void {
        if (this._oldNpc) {
            this._oldNpc = null;
        }
        if (this._newNpc) {
            if (this._newNpc.hasEventListener(MouseEvent.CLICK)) {
                this._newNpc.removeEventListener(MouseEvent.CLICK, this.onClickNpc);
            }
            this._newNpc = null;
        }
        if (this._gameUI) {
            this._gameUI = null;
        }
        super.processMapDispose();
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
    }
}
}
