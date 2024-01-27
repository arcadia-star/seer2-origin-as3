package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.component.teleport.DeferTeleport;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.event.LogicEvent;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.OnlyFlagManager;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.activity.giftMachine.GiftMachine;
import com.taomee.seer2.app.processor.activity.loong.LoongActivity;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.events.ModelLocator;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;
import flash.utils.clearInterval;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;

public class MapProcessor_20 extends TitleMapProcessor {

    private static const FREE_CURE_LEVEL:uint = 30;

    private static const HALLOWEEN_SWAP_ID:uint = 107;

    private static const HALLOWEEN_RES_ID:uint = 400211;


    private var _rightDoorDeferTeleport:DeferTeleport;

    private var _loongActivity:LoongActivity;

    private var _giftMachine:GiftMachine;

    private var _petCheck:SimpleButton;

    private var _petChara:SimpleButton;

    private var _superPetBtn:SimpleButton;

    private var _yueMC:MovieClip;

    private var _petPractice:MovieClip;

    private var _shenMoButton:SimpleButton;

    private var _goUnknown:MovieClip;

    private var _shopBtn:MovieClip;

    private var _plateRotate:MovieClip;

    private var _roateClickCount:int = 0;

    private var _goTransmitCabin:MovieClip;

    private var _spiritHatch:MovieClip;

    private var _addBlood:SimpleButton;

    private var _petAddBloodAnimation:MovieClip;

    private var _birthBtn:SimpleButton;

    private var _twoYearNpc1:Mobile;

    private var _oldNpc1:Mobile;

    private var timeId1:int;

    private var _twoYearNpc:Mobile;

    private var _oldNpc:Mobile;

    private const DAY_LIST:Array = [5190, 5192];

    private const SWAP_LIST:Vector.<int> = Vector.<int>([4199]);

    private const TASK_FINISH_FOV:int = 202496;

    private var timeId:int;

    public function MapProcessor_20(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._petPractice = _map.content["petPractice"];
        this._petPractice.buttonMode = true;
        TooltipManager.addCommonTip(this._petPractice, "资质修炼中的精灵赶快回收吧，旧功能已下架了哦");
        this._petPractice.addEventListener(MouseEvent.CLICK, this.onPetPractice);
        this.initShopBtn();
        this._petChara = _map.front["charaBtn"];
        TooltipManager.addCommonTip(this._petChara, "性格修炼器");
        this._petChara.addEventListener(MouseEvent.CLICK, this.onCharaClick);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomUnitClick);
        this._shenMoButton = _map.content["shenMo"];
        TooltipManager.addCommonTip(this._shenMoButton, "精灵神魔化装置");
        this._shenMoButton.addEventListener(MouseEvent.CLICK, this.onShenMo);
        SeatTipsManager.registerSeat(new Point(252, 142), 20);
        ModelLocator.getInstance().addEventListener(LogicEvent.TRAINER_PK_UPDATE, this.initTwoYearNpcHandle);
        ModelLocator.getInstance().addEventListener(LogicEvent.HOLY_TWOER_CRISIS_UPDATE, this.holyTowerCrisisHandle);
    }

    private function onShenMo(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("PetDeityEvilSelectPanel"), "正在打开...");
    }

    private function onPetPractice(param1:MouseEvent):void {
        ModuleManager.showAppModule("PetPracticeTool");
    }

    private function onYuese(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("YueseNotisiPanel"), "正在打开...");
    }

    private function onYuese2(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("YueseNotisiPanel2"), "正在打开...");
    }

    private function onSuperPet(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_495);
        SeatTipsManager.removeSeat(new Point(750, 400), 20);
        ModuleManager.toggleModule(URLUtil.getAppModule("SuperPetPracticePanel"), "正在打开...");
    }

    private function onYue(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        SwapManager.swapItem(1654, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            DisplayUtil.removeForParent(_yueMC);
        });
    }

    private function onCustomUnitClick(param1:DialogPanelEvent):void {
        var _loc2_:String = DialogPanelEventData(param1.content).params;
        switch (_loc2_) {
            case "HalloweenSwapReply":
                this.startHalloweenSwap();
                break;
            case "inviteFriend":
                this.inviteFriend();
                break;
            case "inviteReward":
                this.inviteReward();
                break;
            case "skillBug":
                this.skillBug();
        }
    }

    private function skillBug():void {
        NpcDialog.show(2, "伊娃博士", [[0, "这里是精灵技能修复通道，请选择您要修复技能的精灵吧！"]], ["王域麒麟", "冥翼撒旦", "万劫魔尊", "不修复"], [function ():void {
            if (checkPet(814)) {
                AlertManager.showConfirm("修复精灵技能，会将该精灵所有已习得的隐藏技能变成未习得，是否接受？", function ():void {
                    SwapManager.swapItem(2818, 1, function (param1:IDataInput):void {
                        AlertManager.showAlert("冥翼撒旦技能修复成功！再次登陆飞船后就会生效了。");
                    }, null, new SpecialInfo(2, checkPet(814).resourceId, checkPet(814).catchTime));
                });
            } else {
                AlertManager.showAlert("你还没有王域麒麟呢，不需要修复它的技能哦");
            }
        }, function ():void {
            if (checkPet(703)) {
                AlertManager.showConfirm("修复精灵技能，会将该精灵所有已习得的隐藏技能变成未习得，是否接受？", function ():void {
                    SwapManager.swapItem(2818, 1, function (param1:IDataInput):void {
                        AlertManager.showAlert("冥翼撒旦技能修复成功！再次登陆飞船后就会生效了。");
                    }, null, new SpecialInfo(2, checkPet(703).resourceId, checkPet(703).catchTime));
                });
            } else {
                AlertManager.showAlert("你还没有冥翼撒旦呢，不需要修复它的技能哦");
            }
        }, function ():void {
            if (checkPet(738)) {
                AlertManager.showConfirm("修复精灵技能，会将该精灵所有已习得的隐藏技能变成未习得，是否接受？", function ():void {
                    SwapManager.swapItem(2818, 1, function (param1:IDataInput):void {
                        AlertManager.showAlert("万劫魔尊技能修复成功！再次登陆飞船后就会生效了。");
                    }, null, new SpecialInfo(2, checkPet(738).resourceId, checkPet(738).catchTime));
                });
            } else {
                AlertManager.showAlert("你还没有万劫魔尊呢，不需要修复它的技能哦");
            }
        }]);
    }

    private function checkPet(param1:uint):PetInfo {
        var _loc2_:PetInfo = null;
        for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
            if (_loc2_.resourceId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    private function initGift():void {
        this._giftMachine = new GiftMachine(1);
    }

    private function initNpc():void {
        MobileManager.getMobile(151, MobileType.NPC).visible = false;
    }

    private function initSuperPrize():void {
        if (DateUtil.inInDateScope(5, 13, 41, 13, 51)) {
            ServerBufferManager.getServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980, this.getBuffer);
        }
    }

    private function getBuffer(param1:ServerBuffer):void {
        var _loc2_:Mobile = MobileManager.getMobile(151, MobileType.NPC);
        var _loc3_:int = param1.readDataAtPostion(10);
        if (_loc3_ == 0) {
            _loc2_.visible = true;
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.CLICK, this.OnSuperPrizeHandler);
        }
    }

    private function OnSuperPrizeHandler(param1:MouseEvent):void {
        var npc:Mobile = null;
        var evt:MouseEvent = param1;
        ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980, 10, 1);
        npc = MobileManager.getMobile(151, MobileType.NPC);
        SwapManager.swapItem(524, 1, function (param1:IDataInput):void {
            var _loc2_:SwapInfo = new SwapInfo(param1);
            npc.removeEventListener(MouseEvent.CLICK, OnSuperPrizeHandler);
            npc.visible = false;
        });
    }

    private function inviteFriend():void {
        var time:uint = new Date(2011, 11, 16).getTime() / 1000;
        if (ActorManager.actorInfo.createTime < time) {
            NpcDialog.show(9, "召集令大使", [[0, "你已经不算新船员啦，只有12月16日以后登船的赛尔才有填写召集官的资格哦，非常抱歉了。"]], ["我知道了！"]);
        } else {
            OnlyFlagManager.RequestFlag(function ():void {
                var _loc1_:int = OnlyFlagManager.getFlag(266);
                if (_loc1_ == 1) {
                    NpcDialog.show(9, "召集令大使", [[0, "你已经登记过你的召集官了，不能再登记其他人哦！"]], ["我知道了！"]);
                } else {
                    NpcDialog.show(9, "召集令大使", [[0, "欢迎你新兵！在这里填写把你招募到赛尔号Ⅱ的那位召集官的米米号吧！"]], ["我走错了！"]);
                    NpcDialog.addInputUnit(requestInviteFriend);
                }
            });
        }
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_227);
    }

    private function requestInviteFriend(param1:int):void {
        if (param1 == ActorManager.actorInfo.id) {
            AlertManager.showAlert("不能登记自己的米米号");
            return;
        }
        Connection.addCommandListener(CommandSet.INVITE_FRIEND_1175, this.onInviteFriendSuccess);
        Connection.addErrorHandler(CommandSet.INVITE_FRIEND_1175, this.onInviteFriendFail);
        Connection.send(CommandSet.INVITE_FRIEND_1175, param1);
    }

    private function onInviteFriendSuccess(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.INVITE_FRIEND_1175, this.onInviteFriendSuccess);
        Connection.removeErrorHandler(CommandSet.INVITE_FRIEND_1175, this.onInviteFriendFail);
        NpcDialog.show(9, "召集令大使", [[0, "很好！这样他也会非常感谢你吧！期待你在赛尔2号上有一番光明的未来！"]], ["我知道了！"]);
        OnlyFlagManager.updataFlag(266, 1);
    }

    private function onInviteFriendFail(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.INVITE_FRIEND_1175, this.onInviteFriendSuccess);
        Connection.removeErrorHandler(CommandSet.INVITE_FRIEND_1175, this.onInviteFriendFail);
        AlertManager.showAlert("米米号不存在");
    }

    private function inviteReward():void {
        Connection.addCommandListener(CommandSet.INVITE_FRIEND_1176, this.onInviteReward);
        Connection.send(CommandSet.INVITE_FRIEND_1176);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_228);
    }

    private function onInviteReward(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.INVITE_FRIEND_1176, this.onInviteReward);
        var _loc2_:int = int(param1.message.getRawDataCopy().readUnsignedInt());
        ModuleManager.toggleModule(URLUtil.getAppModule("InviteRewardPanel"), "正在领取召集令奖励面板...", {"inviteNum": _loc2_});
    }

    private function startHalloweenSwap():void {
        ItemManager.requestItemList(function ():void {
            var _loc1_:uint = uint(ItemManager.getItemQuantityByReferenceId(HALLOWEEN_RES_ID));
            if (_loc1_ >= 100) {
                SwapManager.swapItem(HALLOWEEN_SWAP_ID);
            } else {
                AlertManager.showAlert("你还需要收集" + (100 - _loc1_) + "个布条才能进行兑换");
            }
        });
    }

    private function onLeftDoorClick(param1:MouseEvent):void {
        this._goUnknown.removeEventListener(MouseEvent.CLICK, this.onLeftDoorClick);
        closeInteractor(this._goUnknown);
        this._goUnknown.play();
    }

    private function initShopBtn():void {
        this._shopBtn = _map.content["shopBtn"];
        TooltipManager.addCommonTip(this._shopBtn, "胶囊药剂商店");
        initInteractor(this._shopBtn);
        this._shopBtn.addEventListener(MouseEvent.CLICK, this.onShopClick);
        this._shopBtn.play();
    }

    private function onShopClick(param1:MouseEvent):void {
        var _loc2_:Actor = ActorManager.getActor();
        _loc2_.stand();
        var _loc3_:Object = new Object();
        _loc3_.shopType = 1;
        ModuleManager.toggleModule(URLUtil.getAppModule("BusinessPanel"), "正在打开商店...", _loc3_);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_225);
    }

    private function onCheckClick(param1:MouseEvent):void {
        SeatTipsManager.removeSeat(new Point(860, 180), 20);
        ModuleManager.toggleModule(URLUtil.getAppModule("PetCheckPanel"), "正在打开...");
    }

    private function onCharaClick(param1:MouseEvent):void {
        SeatTipsManager.removeSeat(new Point(805, 190), 20);
        SeatTipsManager.removeSeat(new Point(810, 175), 20);
        ModuleManager.toggleModule(URLUtil.getAppModule("PetCharaPracticePanel"), "正在打开...");
    }

    private function onRoateClick(param1:MouseEvent):void {
        this._plateRotate.play();
        if (this._roateClickCount == 0) {
            ++this._roateClickCount;
            this._plateRotate.play();
        } else if (this._roateClickCount == 1) {
            --this._roateClickCount;
            this._plateRotate.stop();
        }
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_25);
        ModuleManager.toggleModule(URLUtil.getAppModule("PetAppraisalPanel"), "正在打开资质鉴定仪...");
    }

    private function onRightDoorClick(param1:MouseEvent):void {
    }

    private function initRightDoorDeferTeleport():void {
    }

    private function onActorArrivedDoor(param1:Event):void {
    }

    private function initHatch():void {
        this._spiritHatch = _map.front["spiritHatch"];
        initInteractor(this._spiritHatch);
        TooltipManager.addCommonTip(this._spiritHatch, "资质修炼器");
        this._spiritHatch.addEventListener(MouseEvent.CLICK, this.onHatchClick);
    }

    private function onHatchClick(param1:MouseEvent):void {
        this._spiritHatch.play();
        ModuleManager.toggleModule(URLUtil.getAppModule("PetPracticeTool"), "正在打开资质修炼器...");
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_226);
        SeatTipsManager.removeSeat(new Point(865, 305), 20);
    }

    private function initAddBlood():void {
        this._addBlood = _map.content["addBlood"];
        this._addBlood.addEventListener(MouseEvent.CLICK, this.onAddBlookClick);
    }

    private function onAddBlookClick(param1:MouseEvent):void {
        if (PetInfoManager.canCure() == false) {
            ServerMessager.addMessage("你的精灵不需要恢复");
            return;
        }
        if (ActorManager.actorInfo.highestPetLevel <= FREE_CURE_LEVEL) {
            LayerManager.focusOnTopLayer();
            this._petAddBloodAnimation = _map.libManager.getMovieClip("petAddAnimationMC");
            this._petAddBloodAnimation.x = this._addBlood.x;
            this._petAddBloodAnimation.y = this._addBlood.y;
            _map.front.addChild(this._petAddBloodAnimation);
            this._petAddBloodAnimation.play();
            this._petAddBloodAnimation.addEventListener(Event.ENTER_FRAME, this.onPetAddBloodEnd);
        } else {
            AlertManager.showAlert("恢复舱只向精灵最高等级30级以下的新手赛尔开放哦。");
        }
    }

    private function onPetAddBloodEnd(param1:Event):void {
        if (this._petAddBloodAnimation.currentFrame == this._petAddBloodAnimation.totalFrames) {
            this._petAddBloodAnimation.removeEventListener(Event.ENTER_FRAME, this.onPetAddBloodEnd);
            DisplayObjectUtil.removeFromParent(this._petAddBloodAnimation);
            LayerManager.resetOperation();
            this.recoverAllPetBagPet();
        }
    }

    private function recoverAllPetBagPet():void {
        Connection.addCommandListener(CommandSet.ADD_ALLPETBAT_BLOOD_1069, this.onAddAllPetBlood);
        Connection.send(CommandSet.ADD_ALLPETBAT_BLOOD_1069);
    }

    private function onAddAllPetBlood(param1:MessageEvent):void {
        var _loc3_:PetInfo = null;
        Connection.removeCommandListener(CommandSet.ADD_ALLPETBAT_BLOOD_1069, this.onAddAllPetBlood);
        var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        for each(_loc3_ in _loc2_) {
            _loc3_.hp = _loc3_.maxHp;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE, _loc3_);
        }
        ServerMessager.addMessage("你的精灵已经全部恢复了！");
    }

    private function initLoongActivity():void {
        this._loongActivity = new LoongActivity(_map);
    }

    private function initBirth():void {
        this._birthBtn = _map.front["birthBtn"];
        this._birthBtn.addEventListener(MouseEvent.CLICK, this.onBirth);
        TooltipManager.addCommonTip(this._birthBtn, "繁殖舱");
    }

    private function onBirth(param1:MouseEvent):void {
        var _loc2_:Object = new Object();
        _loc2_.birthType = 1;
        ModuleManager.toggleModule(URLUtil.getAppModule("BirthSystemPanel"), "正在打开繁殖...", _loc2_);
        StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_65);
    }

    private function holyTowerCrisisHandle(param1:LogicEvent = null):void {
        var evt:LogicEvent = param1;
        this._oldNpc1 = MobileManager.getMobile(2, MobileType.NPC);
        if (this._oldNpc1) {
            this._oldNpc1.visible = false;
        }
        ServerBufferManager.getServerBuffer(ServerBufferType.HOLY_TWOER_CRISIS_ACT, function (param1:ServerBuffer):void {
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(2));
            if (!_isPlay) {
                if (!MobileManager.getMobile(2, MobileType.NPC)) {
                    timeId = setTimeout(function ():void {
                        initNpc2();
                    }, 2000);
                } else {
                    initNpc2();
                }
            } else if (_oldNpc1) {
                _oldNpc1.visible = true;
            }
        });
    }

    private function initNpc2():void {
        this.afterFinish1();
        this._oldNpc1 = MobileManager.getMobile(2, MobileType.NPC);
        this._oldNpc1.visible = false;
        clearInterval(this.timeId1);
        this._twoYearNpc1 = new Mobile();
        this._twoYearNpc1.width = this._oldNpc1.width;
        this._twoYearNpc1.height = this._oldNpc1.height;
        this._twoYearNpc1.label = this._oldNpc1.label;
        this._twoYearNpc1.setPostion(new Point(this._oldNpc1.x, this._oldNpc1.y));
        this._twoYearNpc1.resourceUrl = this._oldNpc1.resourceUrl;
        this._twoYearNpc1.buttonMode = true;
        this.showMouseHintAtMonster(this._twoYearNpc1);
        MobileManager.addMobile(this._twoYearNpc1, MobileType.NPC);
        this._twoYearNpc1.addEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick1);
    }

    private function onTwoYearNpcClick1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(400, "小赛尔", [[0, "博士博士！你看我发现了什么？！"]], ["这是魔盗团从神迹塔里偷出来的！"], [function ():void {
            NpcDialog.show(2, "博士伊娃", [[0, "这……真的是从神迹塔里找到的吗？！我需要仔细分析一下！如果那个传说是真的的话~~这怎么可能呢。"]], ["究竟是什么呀？！"], [function ():void {
                NpcDialog.show(2, "博士伊娃", [[0, "这居然是真的！我们找了这么久都没找到！居然被一群窃贼先找到了！这就是传说中的神遁精华！"]], ["哇！真的吗？！"], [function ():void {
                    NpcDialog.show(2, "博士伊娃", [[0, "是的！神遁精华可以让精灵神遁觉醒！获得无以伦比的超强防御力！绝对不能让萨伦他们获得神遁精华！"]], ["我们一定会抓住小偷！"], [function ():void {
                        ServerBufferManager.updateServerBuffer(ServerBufferType.HOLY_TWOER_CRISIS_ACT, 2, 1);
                        StatisticsManager.newSendNovice("2015活动", "神迹塔大危机", "完成所有剧情步骤");
                        afterFinish1();
                        ModuleManager.showAppModule("HolyTowerCrisisActPanel");
                    }]);
                }]);
            }]);
        }]);
    }

    private function afterFinish1():void {
        if (this._twoYearNpc1) {
            this._twoYearNpc1.removeEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick1);
            DisplayUtil.removeForParent(this._twoYearNpc1);
            this._twoYearNpc1 = null;
        }
        if (this._oldNpc1) {
            this._oldNpc1.visible = true;
        }
        clearInterval(this.timeId1);
    }

    private function holyTowerCrisisDispose():void {
        if (this._twoYearNpc1) {
            this._twoYearNpc1.removeEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick1);
            DisplayUtil.removeForParent(this._twoYearNpc1);
            this._twoYearNpc1 = null;
        }
        this._oldNpc1 = null;
        clearInterval(this.timeId1);
        ModelLocator.getInstance().removeEventListener(LogicEvent.HOLY_TWOER_CRISIS_UPDATE, this.holyTowerCrisisHandle);
    }

    private function initTwoYearNpcHandle(param1:LogicEvent = null):void {
        var evt:LogicEvent = param1;
        this._oldNpc = MobileManager.getMobile(2, MobileType.NPC);
        if (this._oldNpc) {
            this._oldNpc.visible = false;
        }
        DayLimitListManager.getDaylimitList(this.DAY_LIST, function (param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            if (info.getCount(DAY_LIST[1]) > 0 && info.getCount(DAY_LIST[0]) == 0) {
                if (!MobileManager.getMobile(2, MobileType.NPC)) {
                    timeId = setTimeout(function ():void {
                        initNpc1();
                    }, 2000);
                } else {
                    initNpc1();
                }
            } else if (_oldNpc) {
                _oldNpc.visible = true;
            }
        });
    }

    private function initNpc1():void {
        this.afterFinish();
        this._oldNpc = MobileManager.getMobile(2, MobileType.NPC);
        this._oldNpc.visible = false;
        clearInterval(this.timeId);
        this._twoYearNpc = new Mobile();
        this._twoYearNpc.width = this._oldNpc.width;
        this._twoYearNpc.height = this._oldNpc.height;
        this._twoYearNpc.label = this._oldNpc.label;
        this._twoYearNpc.setPostion(new Point(this._oldNpc.x, this._oldNpc.y));
        this._twoYearNpc.resourceUrl = this._oldNpc.resourceUrl;
        this._twoYearNpc.buttonMode = true;
        this.showMouseHintAtMonster(this._twoYearNpc);
        MobileManager.addMobile(this._twoYearNpc, MobileType.NPC);
        this._twoYearNpc.addEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick);
    }

    private function onTwoYearNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(400, "赛尔", [[0, "教官教官！！在人气大比拼中，我选择支持你了噢！！"]], ["嘿嘿、是不是很感动呀？"], [function ():void {
            NpcDialog.show(2, "伊娃", [[0, "哇！你也选择支持我吗？那我就又能多一票了！~真开心，不过我还想要获得更多的人气~~~~"]], ["我来帮教官拉票吧！"], [function ():void {
                NpcDialog.show(2, "伊娃", [[0, "好呀好呀！~难得你这么热心~~~那你就带着我的徽章去各处替我宣传宣传吧~~嘿嘿！~~记得去人多的地方噢~~去跑个5分钟什么的"]], ["好哒！"], [function ():void {
                    SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                        new SwapInfo(param1);
                        ActorManager.getActor().updateMiKaChangeAct();
                    });
                    afterFinish();
                }]);
            }]);
        }]);
    }

    private function afterFinish():void {
        if (this._twoYearNpc) {
            this._twoYearNpc.removeEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick);
            DisplayUtil.removeForParent(this._twoYearNpc);
            this._twoYearNpc = null;
        }
        if (this._oldNpc) {
            this._oldNpc.visible = true;
        }
        clearInterval(this.timeId);
    }

    private function showMouseHintAtMonster(param1:Mobile):void {
        var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
        _loc2_.y = -_loc2_.height - 50;
        _loc2_.x = (param1.width - param1.width) / 2;
        param1.addChild(_loc2_);
    }

    private function disposeTwoYearNpcHandle():void {
        if (this._twoYearNpc) {
            this._twoYearNpc.removeEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick);
            DisplayUtil.removeForParent(this._twoYearNpc);
            this._twoYearNpc = null;
        }
        this._oldNpc = null;
        clearInterval(this.timeId);
        ModelLocator.getInstance().removeEventListener(LogicEvent.TRAINER_PK_UPDATE, this.initTwoYearNpcHandle);
    }

    override public function dispose():void {
        super.dispose();
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomUnitClick);
        SeatTipsManager.removeSeat(new Point(572, 122), 20);
    }
}
}
