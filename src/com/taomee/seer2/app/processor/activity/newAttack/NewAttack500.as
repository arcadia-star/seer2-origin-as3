package com.taomee.seer2.app.processor.activity.newAttack {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.constant.FunctionalityType;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.dialog.functionality.CustomUnit;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferData;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class NewAttack500 extends BaseNewAttack {

    private static var _fightStatus:uint;


    private var _threeYite:MovieClip;

    public function NewAttack500() {
        super();
        this.setup();
    }

    private function setup():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && _fightStatus == 1) {
            _fightStatus = 0;
            playLoad(function ():void {
                var _loc1_:Date = null;
                var _loc2_:int = 0;
                var _loc3_:Vector.<ServerBufferData> = null;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    _loc1_ = new Date(TimeManager.getServerTime() * 1000);
                    _loc2_ = int(_loc1_.date);
                    _loc3_ = new Vector.<ServerBufferData>();
                    _loc3_.push(new ServerBufferData(0, 1));
                    _loc3_.push(new ServerBufferData(4, _loc2_));
                    ServerBufferManager.updateServerBufferGroup(ServerBufferType.NEW_ATTACK, _loc3_);
                    win();
                } else {
                    noWin();
                }
            });
            return;
        }
        if (checkTime) {
            ServerBufferManager.getServerBuffer(ServerBufferType.NEW_ATTACK, this.getServer, false);
        }
    }

    private function getServer(param1:ServerBuffer):void {
        var _loc6_:Vector.<ServerBufferData> = null;
        var _loc2_:int = param1.readDataAtPostion(0);
        var _loc3_:int = param1.readDataAtPostion(4);
        var _loc4_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc5_:int = int(_loc4_.date);
        if (_loc3_ != _loc5_) {
            (_loc6_ = new Vector.<ServerBufferData>()).push(new ServerBufferData(0, 0));
            _loc6_.push(new ServerBufferData(1, 0));
            _loc6_.push(new ServerBufferData(2, 0));
            _loc6_.push(new ServerBufferData(3, 0));
            ServerBufferManager.updateServerBufferGroup(ServerBufferType.NEW_ATTACK, _loc6_);
            _loc2_ = 0;
        }
        if (_loc2_ != 1) {
            playLoad(this.playComplete);
        }
    }

    private function playComplete():void {
        this.initMC();
        this.initEvent();
    }

    private function initMC():void {
        this._threeYite = getMC("threeYite");
        LayerManager.uiLayer.addChild(this._threeYite);
    }

    private function initEvent():void {
        this._threeYite.buttonMode = true;
        this._threeYite.addEventListener(MouseEvent.CLICK, this.onThreeYite);
    }

    private function onThreeYite(param1:MouseEvent):void {
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDialogShow);
        DialogPanel.showForCommonReturnNpcId(472, "沙伊特", [[3, "你这家伙怎么还不死心！有本事就和我们打一架！"]], "我还没准备呢，再见！");
    }

    private function onDialogShow(param1:DialogPanelEvent):void {
        var _loc2_:CustomUnit = null;
        if (param1.content == 472) {
            DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDialogShow);
            _loc2_ = new CustomUnit(FunctionalityType.QUEST, "新一轮的反攻", "xxx");
            _loc2_.customHandler = this.onUnitClick;
            DialogPanel.functionalityBox.addUnit(_loc2_);
        }
    }

    private function onUnitClick():void {
        _fightStatus = 1;
        FightManager.startFightWithWild(82);
    }

    private function win():void {
        this._threeYite = getMC("threeYitePlay");
        LayerManager.topLayer.addChild(this._threeYite);
        this._threeYite.stop();
        DialogPanel.showForCommonReturnNpcId(473, "虫伊特", [[3, "真没意思，这家伙太强了！我们还是去捉弄别人吧！"]], "别跑啊！", function ():void {
            MovieClipUtil.playMc(_threeYite, 2, _threeYite.totalFrames, function ():void {
                DialogPanel.showForCommonReturnNpcId(NpcUtil.getSeerNpcId(), "我", [[0, "这些捣蛋鬼又回去欺负路人们了，我一定会抓到他们的"]], "必须找到他们！", function ():void {
                    ModuleManager.toggleModule(URLUtil.getAppModule("NewAttackPanel"), "正在打开面板...");
                });
            }, true);
        });
    }

    private function noWin():void {
        this.initMC();
        NpcDialog.show(476, "飞伊特", [[1, "说你弱你还不信，有本事我们再来一局！"]], ["打就打", "我还没准备好"], [function ():void {
            onUnitClick();
        }, function ():void {
            _threeYite.buttonMode = true;
            _threeYite.addEventListener(MouseEvent.CLICK, onThreeYiteTwo);
        }]);
    }

    private function onThreeYiteTwo(param1:MouseEvent):void {
        this.onUnitClick();
    }

    public function mapDispose():void {
        DisplayUtil.removeForParent(this._threeYite);
        this._threeYite = null;
    }
}
}
