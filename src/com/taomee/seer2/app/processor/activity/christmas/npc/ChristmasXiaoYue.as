package com.taomee.seer2.app.processor.activity.christmas.npc {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.activity.christmas.IChristmasNpc;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class ChristmasXiaoYue implements IChristmasNpc {


    private const topicVec:Vector.<String> = Vector.<String>(["上又下土打一个字", "延字加点“言”", "决没水了心情来了", "烁没了火", "圣诞节圣诞老公公放进袜子的第一件礼物是：", "若圣诞老人的驯鹿吃掉了你的铅笔，你该怎麽办。", "小白加小白等于什么？", "鸡的妈妈是谁？", "什么剑是透明的？"]);

    private const keyVec:Vector.<Array> = Vector.<Array>([["圣", "权", "吐"], ["延", "挺", "诞"], ["快", "决", "块"], ["铄", "烁", "乐"], ["姜饼", "礼物盒", "他的脚丫"], ["给它吃泻药", "用钢笔", "告诉妈妈"], ["空白", "小白兔", "黑白配"], ["鸡蛋", "纸", "鸭子"], ["看不见", "亮剑", "仙剑"]]);

    private const keyIndex:Vector.<int> = Vector.<int>([1, 3, 1, 3, 3, 2, 2, 2, 1]);

    private var _res:ResourceLibrary;

    private var _npc:Mobile;

    private var _xiaoyueMC:MovieClip;

    private var _mouseHint:MouseClickHintSprite;

    public function ChristmasXiaoYue(param1:ResourceLibrary) {
        super();
        this._res = param1;
    }

    public function playAnimation():void {
        var url:String = String(URLUtil.getActivityAnimation("9/6"));
        MovieClipUtil.playFullScreen(url, function ():void {
            initMouse();
            initNpc();
        }, false);
    }

    private function initMouse():void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 331;
        this._mouseHint.y = 295;
        LayerManager.topLayer.addChild(this._mouseHint);
    }

    public function initNpc():void {
        var _loc1_:XML = <npc id="452" resId="452" name="晓月兔" dir="1" width="25" height="50" pos="331,313"
                              actorPos="334,325" path="">
            <eventHandler>
                <mouseOver>
                    <HandlerShowNpcSlogan><![CDATA[伦家羞羞了嘛！(⊙_⊙)]]></HandlerShowNpcSlogan>
                </mouseOver>
            </eventHandler>
        </npc>;
        var _loc2_:NpcDefinition = new NpcDefinition(_loc1_);
        this._npc = MobileManager.createNpc(_loc2_);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        NpcDialog.show(411, "晓月兔", [[0, "聪明的孩子总是能够受到我的瞩目！准备好猜谜了吗？有的可是脑筋急转弯哦！"]], ["GOGO！", "一会再来吧！"], [function ():void {
            var random:* = undefined;
            _npc.removeEventListener(MouseEvent.CLICK, onClick);
            random = int(Math.random() * 8);
            NpcDialog.show(411, "晓月兔", [[0, topicVec[random]]], keyVec[random], [function ():void {
                if (keyIndex[random] == 1) {
                    win();
                } else {
                    noWin();
                }
            }, function ():void {
                if (keyIndex[random] == 2) {
                    win();
                } else {
                    noWin();
                }
            }, function ():void {
                if (keyIndex[random] == 3) {
                    win();
                } else {
                    noWin();
                }
            }]);
        }]);
    }

    private function win():void {
        this._xiaoyueMC = this._res.getMovieClip("xiaoyueComplete");
        LayerManager.topLayer.addChild(this._xiaoyueMC);
        this._xiaoyueMC.x = this._npc.x;
        this._xiaoyueMC.y = this._npc.y;
        this._npc.visible = false;
        InteractiveRewardManager.requestReward(55, function (param1:Parser_1060):void {
            var parser:Parser_1060 = param1;
            MovieClipUtil.playMc(_xiaoyueMC, 2, _xiaoyueMC.totalFrames, function ():void {
                if (parser.activityCount == 0) {
                    AlertManager.showAlert("哎哟！我们M5的礼物都被你拿光光了啦！明天再给你吧！");
                } else {
                    parser.showResult();
                }
                DisplayUtil.removeForParent(_xiaoyueMC);
            });
        });
    }

    private function noWin():void {
        NpcDialog.show(411, "晓月兔", [[0, "嘻嘻！我就知道你没我聪明！练练再来吧！"]], ["别走啊……"], [function ():void {
            _xiaoyueMC = _res.getMovieClip("xiaoyueComplete");
            LayerManager.topLayer.addChild(_xiaoyueMC);
            _xiaoyueMC.x = _npc.x;
            _xiaoyueMC.y = _npc.y;
            _npc.visible = false;
            MovieClipUtil.playMc(_xiaoyueMC, 2, _xiaoyueMC.totalFrames, function ():void {
                DisplayUtil.removeForParent(_xiaoyueMC);
            });
        }]);
    }

    public function dispose():void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        this._mouseHint = null;
        if (this._npc) {
            this._npc.visible = true;
            this._npc.removeEventListener(MouseEvent.CLICK, this.onClick);
            DisplayUtil.removeForParent(this._npc);
        }
        this._npc = null;
        DisplayUtil.removeForParent(this._xiaoyueMC);
        this._xiaoyueMC = null;
    }
}
}
