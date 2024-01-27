package com.taomee.seer2.app.processor.copy.handler {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.config.info.CopyItemInfo;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.copy.CopyProcessor;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class CopyProcessor_80028 extends CopyProcessor {


    private var _npc1:MovieClip;

    private var _npc2:MovieClip;

    private var _npc3:MovieClip;

    private var _boss1:MovieClip;

    private var _boss2:MovieClip;

    private var _boss3:MovieClip;

    private var _boss4:MovieClip;

    private var _mouseHint:Sprite;

    private const POS_LIST:Array = [[720, 350], [781, 343], [330, 130], [214, 340], [330, 100], [554, 289], [450, 281], [310, 279]];

    private const FIGHT_INDEX:Vector.<int> = Vector.<int>([464, 466, 467, 468, 465]);

    private var _curIndex:int = 0;

    public function CopyProcessor_80028(param1:CopyItemInfo) {
        super(param1);
    }

    override protected function tatisticsHandle():void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_488);
    }

    override public function returnSceneHandle():void {
        if (this._npc3) {
            _mapModel.content.addChild(this._npc3);
            this._npc3["content"].play();
        }
        if (this._boss1) {
            _mapModel.content.addChild(this._boss1);
            this._boss1["content"].play();
        }
        if (this._boss2) {
            if (this._boss2.currentFrame == 1) {
                (this._boss2["content"] as MovieClip).play();
            }
            _mapModel.content.addChild(this._boss2);
        }
        if (this._boss3) {
            if (this._boss3.currentFrame == 1) {
                (this._boss3["content"] as MovieClip).play();
            }
            _mapModel.content.addChild(this._boss3);
        }
        if (this._boss4) {
            if (this._boss4.currentFrame == 1) {
                (this._boss4["content"] as MovieClip).play();
            }
            _mapModel.content.addChild(this._boss4);
        }
    }

    override public function onAnimationLoaded():void {
        this._npc1 = getResFromDomain("npc_1");
        this._npc1.x = this.POS_LIST[0][0];
        this._npc1.y = this.POS_LIST[0][1];
        (this._npc1["mark"] as MovieClip).visible = false;
        _mapModel.content.addChild(this._npc1);
        this._npc2 = getResFromDomain("npc_2");
        this._npc2.x = this.POS_LIST[1][0];
        this._npc2.y = this.POS_LIST[1][1];
        (this._npc2["mark"] as MovieClip).visible = false;
        _mapModel.content.addChild(this._npc2);
        this.cartoonHandle("80028_1", "", function ():void {
            _boss1 = getResFromDomain("boss_1");
            _boss1.x = POS_LIST[2][0];
            _boss1.y = POS_LIST[2][1];
            (_boss1["mark"] as MovieClip).visible = false;
            _mapModel.content.addChild(_boss1);
            (_npc2["mark"] as MovieClip).visible = true;
            _npc2.buttonMode = true;
            _npc2.addEventListener(MouseEvent.CLICK, onNpc2Click);
        });
    }

    private function onNpc2Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._npc2.removeEventListener(MouseEvent.CLICK, this.onNpc2Click);
        NpcDialog.show(11, "多罗", [[2, "老大！你来的正好！这里有一个长着翅膀的怪物！我和巴蒂还有事！这里就里先交给你啦！"]], ["翅膀…怪物……？"], [function ():void {
            NpcDialog.show(10, "巴蒂", [[2, "是呀！那个怪物挺可爱的！我相信你！你没问题的！我们先闪啦！"]], ["什么怪物嘛……"], [function ():void {
                var anima:* = undefined;
                anima = getResFromDomain("sceneAnima_1");
                _mapModel.front.addChild(anima);
                DisplayUtil.removeForParent(_npc1);
                _npc1 = null;
                DisplayUtil.removeForParent(_npc2);
                _npc2 = null;
                MovieClipUtil.playMc(anima, 2, anima.totalFrames, function ():void {
                    DisplayUtil.removeForParent(anima);
                    anima = null;
                    _npc3 = getResFromDomain("npc_3");
                    _npc3.x = POS_LIST[3][0];
                    _npc3.y = POS_LIST[3][1];
                    _npc3.buttonMode = true;
                    _mapModel.content.addChild(_npc3);
                    _npc3.addEventListener(MouseEvent.CLICK, onNpc3Click);
                }, true);
            }]);
        }]);
    }

    private function onNpc3Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._npc3.removeEventListener(MouseEvent.CLICK, this.onNpc3Click);
        NpcDialog.show(172, "S的思念体", [[0, ActorManager.actorInfo.nick + " 小心!这里与其他的炼狱不同，这里的BOSS是自愿前来的。"]], ["谁会自愿被关在这个暗无天日的地方呀！"], [function ():void {
            NpcDialog.show(172, "S的思念体", [[0, "这个怪物叫做伊利丹，曾经是太空猎魔族的首领，有着一段曲折的故事。它在这里只为了攻破忏悔殿宗的大门，挑战冥王——撒旦！"]], [" 究竟是什么故事？"], [function ():void {
                MovieClipUtil.playNpcTalkNew(URLUtil.getCopySceneTalk("cartoon_1"), 5, [[1, 0]], function ():void {
                    (_npc3["mark"] as MovieClip).visible = false;
                    _boss1.x = POS_LIST[4][0];
                    _boss1.y = POS_LIST[4][1];
                    (_boss1["mark"] as MovieClip).visible = true;
                    _boss1.buttonMode = true;
                    _boss1.addEventListener(MouseEvent.CLICK, onBoss1DialogClick);
                });
            }]);
        }]);
    }

    private function showMouseHintAtMonster(param1:MovieClip):void {
        this.hideMouseHint();
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.y = -this._mouseHint.height + 50;
        this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 + 27;
        param1.addChild(this._mouseHint);
    }

    private function hideMouseHint():void {
        if (Boolean(this._mouseHint) && Boolean(this._mouseHint.parent)) {
            DisplayUtil.removeForParent(this._mouseHint);
            this._mouseHint = null;
        }
    }

    private function onBoss1DialogClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1DialogClick);
        NpcDialog.show(587, "伊利丹", [[0, "你们这群胆小鬼胆敢闯入我的领域！"]], ["我们只是想进入忏悔殿宗"], [function ():void {
            NpcDialog.show(587, "伊利丹", [[0, "忏悔殿宗…撒旦！就凭你们也想挑战它？哈哈哈！这世上撒旦只配有一个对手！就是我！你们只能选择倒在我的黑爪之下！"]], ["看来是非战不可了！"], [function ():void {
                NpcDialog.show(587, "伊利丹", [[0, "跟我打！你们还不够资格，哈哈！先战胜这几个愚蠢的家伙再来找我吧！哈哈哈！"]], ["是谁？！"], [function ():void {
                    var anima:* = undefined;
                    anima = getResFromDomain("sceneAnima_2");
                    _mapModel.front.addChild(anima);
                    MovieClipUtil.playMc(anima, 2, anima.totalFrames, function ():void {
                        DisplayUtil.removeForParent(anima);
                        anima = null;
                        (_boss1["mark"] as MovieClip).visible = false;
                        _boss1.buttonMode = false;
                        _boss2 = getResFromDomain("boss_2");
                        _boss2.x = POS_LIST[5][0];
                        _boss2.y = POS_LIST[5][1];
                        _mapModel.content.addChild(_boss2);
                        _boss3 = getResFromDomain("boss_3");
                        _boss3.x = POS_LIST[6][0];
                        _boss3.y = POS_LIST[6][1];
                        _mapModel.content.addChild(_boss3);
                        _boss4 = getResFromDomain("boss_4");
                        _boss4.x = POS_LIST[7][0];
                        _boss4.y = POS_LIST[7][1];
                        _mapModel.content.addChild(_boss4);
                        cartoonHandle("", "sceneTalk_1", null, function ():void {
                            _boss2.buttonMode = true;
                            showMouseHintAtMonster(_boss2);
                            _boss2.addEventListener(MouseEvent.CLICK, onBossClick);
                            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
                        });
                    }, true);
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:SceneEvent):void {
        var index:int = 0;
        var posIndex:int = 0;
        var evt:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            index = int(FightManager.currentFightRecord.initData.positionIndex);
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                if (this.FIGHT_INDEX.indexOf(index) != -1) {
                    posIndex = this.FIGHT_INDEX.indexOf(index);
                    if (posIndex != 4) {
                        this._curIndex = posIndex;
                    }
                    this.winHandle(posIndex);
                }
            } else {
                if (this.FIGHT_INDEX.indexOf(index) <= 2) {
                    this.cartoonHandle("", "sceneTalk_5", null, function ():void {
                        FightManager.startFightWithWild(FIGHT_INDEX[4]);
                    });
                }
                if (this.FIGHT_INDEX.indexOf(index) == 4) {
                    this._curIndex = 0;
                    this.hideMouseHint();
                    this._boss2.gotoAndStop(1);
                    this._boss3.gotoAndStop(1);
                    this._boss4.gotoAndStop(1);
                    this._boss2.buttonMode = this._boss3.buttonMode = this._boss4.buttonMode = false;
                    this._boss2.removeEventListener(MouseEvent.CLICK, this.onBossClick);
                    this._boss3.removeEventListener(MouseEvent.CLICK, this.onBossClick);
                    this._boss4.removeEventListener(MouseEvent.CLICK, this.onBossClick);
                    this._boss2.buttonMode = true;
                    this.showMouseHintAtMonster(this._boss2);
                    this._boss2.addEventListener(MouseEvent.CLICK, this.onBossClick);
                }
            }
        }
    }

    private function winHandle(param1:int):void {
        var fightIndex:int = param1;
        if (fightIndex == 0) {
            this._boss2.removeEventListener(MouseEvent.CLICK, this.onBossClick);
            this._boss2.buttonMode = false;
            this.hideMouseHint();
            this._boss2.gotoAndStop(2);
            this.cartoonHandle("", "sceneTalk_2", null, function ():void {
                _boss3.buttonMode = true;
                showMouseHintAtMonster(_boss3);
                _boss3.addEventListener(MouseEvent.CLICK, onBossClick);
            });
        } else if (fightIndex == 1) {
            this._boss3.removeEventListener(MouseEvent.CLICK, this.onBossClick);
            this._boss3.buttonMode = false;
            this.hideMouseHint();
            this._boss3.gotoAndStop(2);
            this.cartoonHandle("", "sceneTalk_3", null, function ():void {
                _boss4.buttonMode = true;
                showMouseHintAtMonster(_boss4);
                _boss4.addEventListener(MouseEvent.CLICK, onBossClick);
            });
        } else if (fightIndex == 2) {
            this._boss4.removeEventListener(MouseEvent.CLICK, this.onBossClick);
            this._boss4.buttonMode = false;
            this.hideMouseHint();
            this._boss4.gotoAndStop(2);
            this.cartoonHandle("", "sceneTalk_4", null, function ():void {
                cartoonHandle("80028_2", "", function ():void {
                    DisplayUtil.removeForParent(_boss2);
                    _boss2 = null;
                    DisplayUtil.removeForParent(_boss3);
                    _boss3 = null;
                    DisplayUtil.removeForParent(_boss4);
                    _boss4 = null;
                    _boss1.buttonMode = true;
                    _boss1.addEventListener(MouseEvent.CLICK, onBoss1DialogClick1);
                });
            });
        } else if (fightIndex == 3) {
            this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1DialogClick1);
            DisplayUtil.removeForParent(this._boss1);
            this._boss1 = null;
            completeTipShow(1, 1, "傲慢之芯");
        } else if (fightIndex == 4) {
        }
    }

    private function onBoss1DialogClick1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(587, "伊利丹", [[0, "哈哈哈！到此为止了！做好失败的领悟了吗！"]], ["来吧恶魔！！", "我要准备一下！"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX[3]);
        }]);
    }

    private function onBossClick(param1:MouseEvent):void {
        switch (param1.currentTarget) {
            case this._boss2:
                FightManager.startFightWithWild(this.FIGHT_INDEX[0]);
                break;
            case this._boss3:
                FightManager.startFightWithWild(this.FIGHT_INDEX[1]);
                break;
            case this._boss4:
                FightManager.startFightWithWild(this.FIGHT_INDEX[2]);
        }
    }

    private function cartoonHandle(param1:String, param2:String = "", param3:Function = null, param4:Function = null):void {
        var fullScreenName:String = param1;
        var sceneTalkName:String = param2;
        var fun:Function = param3;
        var fun1:Function = param4;
        MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen(fullScreenName), function ():void {
            var _scenMc:MovieClip = null;
            if (null != fun) {
                fun.call();
            }
            if (sceneTalkName != "") {
                _scenMc = getResFromDomain(sceneTalkName);
                _mapModel.front.addChild(_scenMc);
                MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
                    DisplayUtil.removeForParent(_scenMc);
                    _scenMc = null;
                    if (null != fun1) {
                        fun1.call();
                    }
                }, true);
            }
        }, true, true, 2, false);
    }

    override public function dispose():void {
        super.dispose();
        this.hideMouseHint();
        if (this._npc1) {
            DisplayUtil.removeForParent(this._npc1);
            this._npc1 = null;
        }
        if (this._npc2) {
            this._npc2.removeEventListener(MouseEvent.CLICK, this.onNpc2Click);
            DisplayUtil.removeForParent(this._npc2);
            this._npc2 = null;
        }
        if (this._npc3) {
            this._npc3.removeEventListener(MouseEvent.CLICK, this.onNpc3Click);
            DisplayUtil.removeForParent(this._npc3);
            this._npc3 = null;
        }
        if (this._boss1) {
            this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1DialogClick);
            this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1DialogClick1);
            DisplayUtil.removeForParent(this._boss1);
            this._boss1 = null;
        }
        if (this._boss2) {
            this._boss2.removeEventListener(MouseEvent.CLICK, this.onBossClick);
            DisplayUtil.removeForParent(this._boss2);
            this._boss2 = null;
        }
        if (this._boss3) {
            this._boss3.removeEventListener(MouseEvent.CLICK, this.onBossClick);
            DisplayUtil.removeForParent(this._boss3);
            this._boss3 = null;
        }
        if (this._boss4) {
            this._boss4.removeEventListener(MouseEvent.CLICK, this.onBossClick);
            DisplayUtil.removeForParent(this._boss4);
            this._boss4 = null;
        }
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
    }
}
}
