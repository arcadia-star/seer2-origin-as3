package com.taomee.seer2.app.processor.activity.vipClub {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;

import org.taomee.manager.EventManager;
import org.taomee.utils.DisplayUtil;

public class VipClub {

    private static var _resLib:ResourceLibrary;

    private static var _isQuest:Boolean;


    public function VipClub() {
        super();
    }

    public static function entryQuest1():void {
        MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("vipClub/quest1"), function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            QuestManager.completeStep(10147, 1);
        }, true, false, 2);
    }

    private static function onComplete(param1:QuestEvent):void {
        var questId:uint;
        var event:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, onComplete);
        questId = uint(event.questId);
        if (questId == 10147) {
            AlertManager.showAlert("你已经获得了3天的VIP试用好好享受俱乐部狂欢吧！", function ():void {
                entryQuest2();
            });
        }
        if (questId == 10148) {
            entryQuest3();
        }
    }

    public static function entryQuest2():void {
        if (QuestManager.isCanAccepted(10148)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(10148);
            return;
        }
        NpcDialog.show(181, "俱乐部报纸", [[1, "恭喜你成为了俱乐部的一员！我们一定会合作愉快的不是吗？"]], ["但是，俱乐部究竟是什么？我还不明白呢……"], [function ():void {
            NpcDialog.show(181, "俱乐部报纸", [[1, "嗯，看来我有必要好好给你介绍一下了！首先，你要知道，俱乐部会员的与众不同之处在哪里~"]], ["说说看？"], [function ():void {
                NpcDialog.show(181, "俱乐部报纸", [[1, "想要成为训练师，不断磨练自己很重要。俱乐部会员能够比常人拥有更多的经验，更快成为最强训练师！"]], ["哦？"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("vipClub/quest2_1"), function ():void {
                        NpcDialog.show(181, "俱乐部报纸", [[1, "在获得精灵伙伴的道路上，俱乐部会员的捕捉概率也比常人大大提升了！"]], ["哦？"], [function ():void {
                            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("vipClub/quest2_2"), function ():void {
                                NpcDialog.show(181, "俱乐部报纸", [[1, "俱乐部的神勇6武士套装也是闻名星球的！会员们通过锻造可以获取武士套装，穿上它，你觉得自己在战场上更加孔武有力了！"]], ["哦？"], [function ():void {
                                    MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("vipClub/quest2_3"), function ():void {
                                        NpcDialog.show(181, "俱乐部报纸", [[1, "还有每周的俱乐部礼包，取之不尽的赛尔豆超级POS机，便携式精灵仓库，基地更多精灵锻炼位……（进入了想入非非的状态）"]], ["喂，醒醒，醒一醒……！"], [function ():void {
                                            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                                            QuestManager.completeStep(10148, 1);
                                        }]);
                                    }, false, false, 2);
                                }]);
                            }, false, false, 2);
                        }]);
                    }, false, false, 2);
                }]);
            }]);
        }]);
    }

    public static function entryQuest3():void {
        if (QuestManager.isCanAccepted(10149)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(10149);
            return;
        }
        if (_resLib == null) {
            QueueLoader.load(URLUtil.getActivityAnimation("vipClub/quest3"), LoadType.DOMAIN, onLoadComplete);
            return;
        }
        NpcDialog.show(181, "俱乐部报纸", [[1, "咳，我说了多久了？事不宜迟，我们也别再纸上谈兵了，来，随我去俱乐部好好体验一下吧！"]], ["等等，我考虑一下，喂……就这么跟着去了……"], [function ():void {
            if (SceneManager.active.mapID == 8011) {
                onNextQuest2();
            } else {
                SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete);
                _isQuest = true;
                SceneManager.changeScene(SceneType.LOBBY, 8011);
            }
        }]);
    }

    private static function onSwitchComplete(param1:SceneEvent):void {
        if (SceneManager.active.mapID == 8011 && _isQuest) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete);
            _isQuest = false;
            onNextQuest2();
        }
    }

    private static function onNextQuest2():void {
        var mc1:MovieClip = null;
        mc1 = _resLib.getMovieClip("quest1");
        LayerManager.topLayer.addChild(mc1);
        MovieClipUtil.playMc(mc1, 1, mc1.totalFrames, function ():void {
            DisplayUtil.removeForParent(mc1);
            if (ActorManager.actorInfo.birthdayInfo.isOpen == false) {
                EventManager.addEventListener("OPEN_BIRTHDAY", onOpenBirthday);
                ModuleManager.toggleModule(URLUtil.getAppModule("BirthdayPanel"), "正在打开...");
            } else {
                NpcDialog.show(181, "俱乐部报纸", [[1, "哇，资料库中已经有你的资料了！"]], ["其实我是老会员了你不知道吗？"], [function ():void {
                    nextQuest3();
                }]);
            }
        }, true);
    }

    private static function onOpenBirthday(param1:Event):void {
        EventManager.removeEventListener("OPEN_BIRTHDAY", onOpenBirthday);
        nextQuest3();
    }

    private static function nextQuest3():void {
        NpcDialog.show(181, "俱乐部报纸", [[1, "嗯，你已经成为俱乐部守护者团队的一员了。打开你的个人信息面板就能启用称号哦！"]], ["成为守护者会有什么好处？"], [function ():void {
            NpcDialog.show(181, "俱乐部报纸", [[1, "当到了你的星座守护月的时候，就可以领取你的专属星座守护礼包啦！其中包括你的专用战斗圣衣，对你的专属星座精灵有极大加成哦！"]], ["那么厉害？"], [function ():void {
                var mc2:* = undefined;
                mc2 = _resLib.getMovieClip("quest2");
                LayerManager.topLayer.addChild(mc2);
                MovieClipUtil.playMc(mc2, 1, mc2.totalFrames, function ():void {
                    var mc3:* = undefined;
                    DisplayUtil.removeForParent(mc2);
                    ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"), "正在vip面板...", {"currentTab": 4});
                    mc3 = _resLib.getMovieClip("quest3");
                    LayerManager.topLayer.addChild(mc3);
                    MovieClipUtil.playMc(mc3, 1, mc3.totalFrames, function ():void {
                        var mc4:*;
                        ModuleManager.closeForName("NewVipPanel");
                        DisplayUtil.removeForParent(mc3);
                        ModuleManager.toggleModule(URLUtil.getAppModule("VipLevelPanel2"), "...");
                        mc4 = _resLib.getMovieClip("quest4");
                        LayerManager.topLayer.addChild(mc4);
                        MovieClipUtil.playMc(mc4, 1, mc4.totalFrames, function ():void {
                            ModuleManager.closeForName("VipLevelPanel2");
                            DisplayUtil.removeForParent(mc3);
                            NpcDialog.show(181, "俱乐部报纸", [[1, "时间不多了，我必须要再去执行更多的任务了。如果还有更多想要了解的，可以点击右下方的NONO头像来查看俱乐部手册！"]], ["你要走了吗？"], [function ():void {
                                var nono:* = undefined;
                                nono = _resLib.getMovieClip("nono");
                                nono.x = 540;
                                nono.y = 245;
                                LayerManager.topLayer.addChild(nono);
                                MovieClipUtil.playMc(nono, 1, nono.totalFrames, function ():void {
                                    DisplayUtil.removeForParent(nono);
                                    NpcDialog.show(181, "俱乐部报纸", [[1, "和你相处真的很愉快！作为感谢，将那柄改变我命运的魔杖送给你！它会有助于你完成使命的！"]], ["嗯，再见哟！"], [function ():void {
                                        QuestManager.completeStep(10149, 1);
                                    }]);
                                }, true);
                            }]);
                        }, true);
                    }, true);
                }, true);
            }]);
        }]);
    }

    private static function onLoadComplete(param1:ContentInfo):void {
        _resLib = new ResourceLibrary(param1.content);
        entryQuest3();
    }

    private static function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, onAccept);
        var _loc2_:uint = uint(param1.questId);
        if (_loc2_ == 10148) {
            entryQuest2();
        }
        if (_loc2_ == 10149) {
            entryQuest3();
        }
    }
}
}
