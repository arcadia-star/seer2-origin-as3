package com.taomee.seer2.app.processor.quest.handler.activity.quest30030 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30030_10 extends QuestMapHandler {


    private var _letter:MovieClip;

    private var _npc_0:MovieClip;

    private var _npc_1:MovieClip;

    private var _panel:MovieClip;

    private var _panel_npc_normal:MovieClip;

    private var _panel_npc_angry:MovieClip;

    private var _panel_npc_happy:MovieClip;

    private var _panel_Btn:SimpleButton;

    private var _isRight:Boolean;

    public function QuestMapHandler_30030_10(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initNpc();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initNpcAgain();
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "10122_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30030_0"), function ():void {
                _npc_0 = _processor.resLib.getMovieClip("npc");
                _map.content.addChild(_npc_0);
                NpcDialog.show(1, "辛迪船长", [[0, "&%￥@…$#%居然是……贾斯汀这个老伙计来的信！快一起看看他写了什么？"]], ["好呀好呀！我也要看！"], [function ():void {
                    _letter = _processor.resLib.getMovieClip("letter");
                    _map.front.addChild(_letter);
                    var _loc1_:* = _letter["closeBtn"] as SimpleButton;
                    _loc1_.addEventListener(MouseEvent.CLICK, onCloseLetterHandler);
                }]);
            }, true, false, 2);
        }
    }

    private function onCloseLetterHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._letter) {
            DisplayUtil.removeForParent(this._letter);
        }
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[1, "哇塞！贾斯汀站长要来赛尔号II啦！我可是他的铁皮粉丝呢！下周就要来了，我怎么做才能让贾斯汀站长对我有个深刻的印象呢？"]], [], [function ():void {
            NpcDialog.show(1, "辛迪船长", [[0, "别着急，我这里有一些赛尔号II的纪念明信片，你要不要写留言送给你的大偶像呀？"]], [], [function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[1, "明信片！好耶！可是我们的飞船被吸住了，怎么前往赛尔号呀，唉…愁死我了！"]], [], [function ():void {
                    NpcDialog.show(1, "辛迪船长", [[0, "哈哈！这个简单呀，你看那只精灵，他能把贾斯汀的信送过来，相信一定也能把你的心意送回去，快去问问它吧！"]], ["船长你真棒！我这就问问它。"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                        QuestManager.accept(_quest.id);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        this.initNpc();
    }

    private function initNpc():void {
        if (this._npc_0) {
            DisplayUtil.removeForParent(this._npc_0);
        }
        this._npc_1 = _processor.resLib.getMovieClip("npc1");
        _map.content.addChild(this._npc_1);
        this._npc_1.buttonMode = true;
        this._npc_1.addEventListener(MouseEvent.CLICK, this.onNpcTalkHandler);
    }

    private function onNpcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(515, "邮差", [[0, "你有事吗？本帅休息一下之后，就要回去向贾斯汀站长汇报了"]], ["啊！英俊潇洒的邮差，能拜托你一件小事吗？"], [function ():void {
            NpcDialog.show(515, "邮差", [[1, "哈哈哈！你再怎么夸我，我也不会高兴的，嘿哈哈哈！说吧，你有什么事要拜托给本帅哥的。"]], ["你能帮我给贾斯汀站长送一封信吗？"], [function ():void {
                NpcDialog.show(515, "邮差", [[0, "这个嘛…本帅哥可不是普通的邮递员，不能随随便便就帮赛尔送信的。除非…"]], ["除非什么？"], [function ():void {
                    NpcDialog.show(515, "邮差", [[0, "除非你这里有我最感兴趣的东西…"]], ["嗯…最感兴趣的东西…看这身材…难道是？"], [function ():void {
                        initPanel();
                    }]);
                }]);
            }]);
        }]);
    }

    private function initPanel():void {
        var _loc1_:MovieClip = null;
        var _loc2_:SimpleButton = null;
        var _loc3_:SimpleButton = null;
        var _loc4_:SimpleButton = null;
        var _loc5_:SimpleButton = null;
        var _loc6_:SimpleButton = null;
        var _loc7_:SimpleButton = null;
        var _loc8_:SimpleButton = null;
        var _loc9_:SimpleButton = null;
        this._panel = _processor.resLib.getMovieClip("panel");
        _map.front.addChild(this._panel);
        _loc1_ = this._panel["npc"] as MovieClip;
        this._panel_npc_normal = _loc1_["normal"] as MovieClip;
        this._panel_npc_angry = _loc1_["angry"] as MovieClip;
        this._panel_npc_happy = _loc1_["happy"] as MovieClip;
        this._panel_Btn = this._panel["joinBtn"] as SimpleButton;
        _loc3_ = this._panel["btn1"] as SimpleButton;
        _loc4_ = this._panel["btn2"] as SimpleButton;
        _loc5_ = this._panel["btn3"] as SimpleButton;
        _loc6_ = this._panel["btn4"] as SimpleButton;
        _loc7_ = this._panel["btn5"] as SimpleButton;
        _loc8_ = this._panel["btn6"] as SimpleButton;
        _loc9_ = this._panel["closeBtn"] as SimpleButton;
        this._panel_npc_normal.visible = true;
        this._panel_npc_angry.visible = false;
        this._panel_npc_happy.visible = false;
        this._panel_Btn.visible = false;
        _loc3_.addEventListener(MouseEvent.CLICK, this.onWrongHandler);
        _loc4_.addEventListener(MouseEvent.CLICK, this.onWrongHandler);
        _loc5_.addEventListener(MouseEvent.CLICK, this.onWrongHandler);
        _loc6_.addEventListener(MouseEvent.CLICK, this.onWrongHandler);
        _loc7_.addEventListener(MouseEvent.CLICK, this.onWrongHandler);
        _loc8_.addEventListener(MouseEvent.CLICK, this.onRightHandler);
        _loc9_.addEventListener(MouseEvent.CLICK, this.onCloseHandler);
    }

    private function onWrongHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._panel_npc_normal.visible = false;
        this._panel_npc_angry.visible = true;
        this._panel_npc_happy.visible = false;
        this._panel_Btn.visible = false;
        MovieClipUtil.playMc(this._panel_npc_angry, 1, this._panel_npc_angry.totalFrames, function ():void {
            _panel_npc_normal.visible = true;
            _panel_npc_angry.visible = false;
            _panel_npc_happy.visible = false;
        });
    }

    private function onRightHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._panel_npc_normal.visible = false;
        this._panel_npc_angry.visible = false;
        this._panel_npc_happy.visible = true;
        MovieClipUtil.playMc(this._panel_npc_happy, 1, this._panel_npc_happy.totalFrames, function ():void {
            _panel_npc_normal.visible = false;
            _panel_npc_angry.visible = false;
            _panel_npc_happy.visible = true;
            _panel_Btn.visible = true;
            _panel_Btn.addEventListener(MouseEvent.CLICK, onJoinHandler);
        });
    }

    private function onJoinHandler(param1:MouseEvent):void {
        this._isRight = true;
        this.closePanel();
    }

    private function onCloseHandler(param1:MouseEvent):void {
        this.closePanel();
    }

    private function closePanel():void {
        if (this._panel) {
            DisplayUtil.removeForParent(this._panel);
        }
        if (this._isRight) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
            QuestManager.completeStep(_quest.id, 1);
        }
    }

    private function onStepCompleteHandler(param1:QuestEvent):void {
        this._npc_1.removeEventListener(MouseEvent.CLICK, this.onNpcTalkHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
        this.NpcTalk();
    }

    private function initNpcAgain():void {
        this._npc_1 = _processor.resLib.getMovieClip("npc1");
        _map.content.addChild(this._npc_1);
        this._npc_1.buttonMode = true;
        this._npc_1.addEventListener(MouseEvent.CLICK, this.onNpcTalkAgainHandler);
    }

    private function onNpcTalkAgainHandler(param1:MouseEvent):void {
        this.NpcTalk();
    }

    private function NpcTalk():void {
        NpcDialog.show(515, "邮差", [[4, "啊哈！这是我目前看到的最帅的邮票了！即使把它送给我我也不会高兴的！哈哈哈！哈哈！"]], ["这可是我最珍惜的收藏了，那我请你帮的忙"], [function ():void {
            NpcDialog.show(515, "邮差", [[4, "哈哈！本帅就答应你啦！你有多少邮票，我就帮你送多少次信！送多少次都可以！哈哈！"]], ["好吧，那你要把信安全交给我的偶像贾斯汀站长哦！"], [function ():void {
                NpcDialog.show(515, "邮差", [[0, "你就放心吧！我一直都是全宇宙最靠谱儿的超时空邮差！把信给我吧，我这就给你送去！"]], ["那好！就拜托你啦！"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30030_1"), function ():void {
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onStep2CompleteHandler);
                        QuestManager.completeStep(_quest.id, 2);
                    }, true, false, 2);
                }]);
            }]);
        }]);
    }

    private function onStep2CompleteHandler(param1:QuestEvent):void {
        this._npc_1.removeEventListener(MouseEvent.CLICK, this.onNpcTalkHandler);
        if (this._npc_1) {
            DisplayUtil.removeForParent(this._npc_1);
        }
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepCompleteHandler);
    }

    override public function dispose():void {
        if (this._npc_0) {
            DisplayUtil.removeForParent(this._npc_0);
        }
        if (this._panel) {
            DisplayUtil.removeForParent(this._panel);
        }
        if (this._npc_1) {
            DisplayUtil.removeForParent(this._npc_1);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepCompleteHandler);
        super.dispose();
    }
}
}
