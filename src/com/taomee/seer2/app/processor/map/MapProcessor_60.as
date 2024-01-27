package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.PetMeleeActivity;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.component.teleport.DeferTeleport;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.event.LogicEvent;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.ItemUtil;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.InitPetTrainingManager;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1051;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct.GrabXiaoYueSeAct;
import com.taomee.seer2.app.processor.activity.leiyiFight.LeiyiFight60;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
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

public class MapProcessor_60 extends TitleMapProcessor {

    private static const DIALOG_CONTENT:Array = ["主宠训练营的训练，需要有聪颖的智慧，你们准备好了吗？", "主宠训练营的训练，需要有强健的体能，你们准备好了吗？", "主宠训练营的训练，需要有坚强的耐力，你们准备好了吗？"];

    public static const INIT_PET_DIALOG_INFO:Array = [{
        "id": 420,
        "name": "迪兰特"
    }, {
        "id": 421,
        "name": "休罗斯"
    }, {
        "id": 422,
        "name": "拉奥叶"
    }];

    private static const MOVESKYCONST:int = 1;

    private static const MOVESKYMAX:int = 0;

    private static const MOVESKYMIN:int = -500;

    private static var _lastChallengeIndex:int;


    private var _teleport:Teleport;

    private var _goTransmitCabin:MovieClip;

    private var _screen:MovieClip;

    private var _goTransmitDeferTeleport:DeferTeleport;

    private var _shoolOpenTrain:LeiyiFight60;

    private var _petMelee:MovieClip;

    private var _initPetBtn:MovieClip;

    private var _grabXiaoYueSeAct:GrabXiaoYueSeAct;

    private var _moveSkyType:int;

    private var _skyInterval:int;

    private var _waterPet:MovieClip;

    private var _firePet:MovieClip;

    private var _grassPet:MovieClip;

    private var _petPyramidBtn:SimpleButton;

    private var _petPyramidAnn:MovieClip;

    private var _twoYearNpc:Mobile;

    private var _oldNpc:Mobile;

    private const DAY_LIST:Array = [5190, 5192];

    private const SWAP_LIST:Vector.<int> = Vector.<int>([4199]);

    private const TASK_FINISH_FOV:int = 202496;

    private var timeId:int;

    public function MapProcessor_60(param1:MapModel) {
        super(param1);
    }

    public static function startChallenge(param1:int):void {
        _lastChallengeIndex = param1;
        FightManager.startFightWithWild(38);
    }

    override public function init():void {
        SeatTipsManager.registerSeat(new Point(388, 200), 60);
        GrabXiaoYueSeAct.getInstance().setup(_map);
        StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_196);
        this.initPetTraining();
        this.initStarrySky();
        this.initDoor();
        this.initScreen();
        this.initDoorDeferTeleport();
        this.initPetPyramidChallenge();
        this.initShoolOpen();
        PetMeleeActivity.setup60();
        this.initPetMelee();
        ModelLocator.getInstance().addEventListener(LogicEvent.TRAINER_PK_UPDATE, this.initTwoYearNpcHandle);
    }

    private function initStarrySky():void {
        this._skyInterval = 0;
    }

    private function initPetMelee():void {
        this._petMelee = _map.content["petMelee"];
        this._petMelee.buttonMode = true;
        TooltipManager.addCommonTip(this._petMelee, "精灵大乱斗");
        this._petMelee.addEventListener(MouseEvent.CLICK, this.onPetMelee);
    }

    private function onPetMelee(param1:MouseEvent):void {
        SeatTipsManager.removeSeat(new Point(537, 120), 60);
        PetMeleeActivity.clickPetmelee();
    }

    private function initSuperPrize():void {
        var npc:Mobile = null;
        npc = MobileManager.getMobile(151, MobileType.NPC);
        if (DateUtil.inInDateScope(5, 13, 31, 13, 41)) {
            ServerBufferManager.getServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980, function (param1:ServerBuffer):void {
                var _loc2_:int = param1.readDataAtPostion(9);
                if (_loc2_ == 0) {
                    npc.visible = true;
                    npc.buttonMode = true;
                    npc.addEventListener(MouseEvent.CLICK, OnSuperPrizeHandler);
                    ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980, 9, 1);
                }
            });
        }
    }

    private function initShoolOpen():void {
        this._shoolOpenTrain = new LeiyiFight60();
    }

    private function OnSuperPrizeHandler(param1:MouseEvent):void {
        var npc:Mobile = null;
        var evt:MouseEvent = param1;
        npc = MobileManager.getMobile(151, MobileType.NPC);
        SwapManager.swapItem(523, 1, function (param1:IDataInput):void {
            var _loc2_:SwapInfo = new SwapInfo(param1);
            npc.removeEventListener(MouseEvent.CLICK, OnSuperPrizeHandler);
            npc.visible = false;
        });
    }

    private function moveSky(param1:Event):void {
        ++this._skyInterval;
        if (this._skyInterval == 2) {
            this._skyInterval = 0;
            return;
        }
    }

    private function initScreen():void {
        this._screen = _map.content["screen"];
        initInteractor(this._screen);
        this._screen.addEventListener(MouseEvent.MOUSE_OVER, this.onScreenOver);
        this._screen.addEventListener(MouseEvent.MOUSE_OUT, this.offScreenOver);
    }

    private function onScreenOver(param1:MouseEvent):void {
        this._screen.gotoAndStop(2);
    }

    private function offScreenOver(param1:MouseEvent):void {
        this._screen.gotoAndStop(1);
    }

    private function initDoor():void {
    }

    private function onDoorClick(param1:MouseEvent):void {
        this._goTransmitDeferTeleport.actorMoveClose();
    }

    private function initDoorDeferTeleport():void {
    }

    private function onActorArrivedDoor(param1:Event):void {
    }

    private function initPetTraining():void {
        this._waterPet = _map.content["waterPet"];
        this._waterPet.buttonMode = true;
        this._waterPet.addEventListener(MouseEvent.CLICK, this.onWaterPetTraining);
        this._firePet = _map.content["firePet"];
        this._firePet.buttonMode = true;
        this._firePet.addEventListener(MouseEvent.CLICK, this.onFirePetTraining);
        this._grassPet = _map.content["grassPet"];
        this._grassPet.buttonMode = true;
        this._grassPet.addEventListener(MouseEvent.CLICK, this.onGrassPetTraining);
        this._grassPet = _map.content["grassPet"];
        this._grassPet.buttonMode = true;
        this._grassPet.addEventListener(MouseEvent.CLICK, this.onGrassPetTraining);
        _map.content["ballBtn"].addEventListener(MouseEvent.CLICK, this.onBall);
    }

    private function onBall(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("PetMelee2Panel"), "......");
    }

    private function onWaterPetTraining(param1:MouseEvent):void {
        var _loc2_:PetInfo = PetInfoManager.getFirstPetInfo();
        if (_loc2_ == null || _loc2_.resourceId > 3) {
            NpcDialog.show(420, "迪兰特", [[0, "欢迎参加主宠训练营！我这里只接受水系主宠的训练，把它设为首发精灵后再来找我！"]], ["好的，我知道了！"]);
        } else {
            this.startTraining();
        }
    }

    private function onFirePetTraining(param1:MouseEvent):void {
        var _loc2_:PetInfo = PetInfoManager.getFirstPetInfo();
        if (_loc2_ == null || _loc2_.resourceId < 4 || _loc2_.resourceId > 6) {
            NpcDialog.show(421, "休罗斯", [[0, "HOHO~~主宠训练营欢迎你！我只接受火系主宠的训练，把它设为首发精灵后再来找我！"]], ["好的，我知道了！"]);
        } else {
            this.startTraining();
        }
    }

    private function onGrassPetTraining(param1:MouseEvent):void {
        var _loc2_:PetInfo = PetInfoManager.getFirstPetInfo();
        if (_loc2_ == null || _loc2_.resourceId < 7 || _loc2_.resourceId > 9) {
            NpcDialog.show(422, "拉奥叶", [[0, "呵呵~欢迎来主宠训练营，我只接受草系主宠的训练，把它设为首发精灵后再来找我！"]], ["好的，我知道了！"]);
        } else {
            this.startTraining();
        }
    }

    private function startTraining():void {
        this.validateTrainingStatus();
    }

    private function validateTrainingStatus():void {
        Connection.addCommandListener(CommandSet.INITPET_TRAINING_STEP_STATUS_1088, this.onGetTrainingStatus);
        Connection.send(CommandSet.INITPET_TRAINING_STEP_STATUS_1088, PetInfoManager.getFirstPetInfo().catchTime, 1, 6);
    }

    private function onGetTrainingStatus(param1:MessageEvent):void {
        var _loc8_:uint = 0;
        var _loc2_:uint = (PetInfoManager.getFirstPetInfo().resourceId - 1) / 3;
        Connection.removeCommandListener(CommandSet.INITPET_TRAINING_STEP_STATUS_1088, this.onGetTrainingStatus);
        var _loc3_:IDataInput = param1.message.getRawData();
        var _loc4_:uint = uint(_loc3_.readUnsignedInt());
        var _loc5_:uint = uint(_loc3_.readUnsignedInt());
        var _loc6_:uint = 0;
        while (_loc6_ < _loc5_) {
            _loc8_ = uint(_loc3_.readUnsignedInt());
            if (_loc3_.readUnsignedInt() == 0) {
                InitPetTrainingManager.currentStep = _loc8_;
                NpcDialog.show(INIT_PET_DIALOG_INFO[_loc2_].id, INIT_PET_DIALOG_INFO[_loc2_].name, [[0, DIALOG_CONTENT[_loc2_]]], ["是的，现在就开始训练吧！", "我待会再来找你..."], [this.showTrainingPanel, null]);
                return;
            }
            _loc6_++;
        }
        var _loc7_:* = "恭喜你，今天" + PetInfoManager.getFirstPetInfo().name + "完成了所有训练，请明天再来~";
        NpcDialog.show(INIT_PET_DIALOG_INFO[_loc2_].id, INIT_PET_DIALOG_INFO[_loc2_].name, [[0, _loc7_]], ["好的，我知道了！"]);
    }

    private function onInitPet(param1:MouseEvent):void {
    }

    private function showTrainingPanel():void {
        ModuleManager.showModule(URLUtil.getAppModule("InitPetTrainingPanel"), "正在打开初始精灵训练...", {"currentStep": InitPetTrainingManager.currentStep});
    }

    private function clearPetTraining():void {
        Connection.removeCommandListener(CommandSet.INITPET_TRAINING_STEP_STATUS_1088, this.onGetTrainingStatus);
        this._waterPet.removeEventListener(MouseEvent.CLICK, this.onWaterPetTraining);
        this._firePet.removeEventListener(MouseEvent.CLICK, this.onFirePetTraining);
        this._grassPet.removeEventListener(MouseEvent.CLICK, this.onGrassPetTraining);
        this._waterPet = null;
        this._firePet = null;
        this._grassPet = null;
    }

    override public function dispose():void {
        this.clearPetTraining();
        this._teleport = null;
        this.disposePetPyramidChallenge();
        this._shoolOpenTrain.dispose();
        GrabXiaoYueSeAct.getInstance().dispose();
        SeatTipsManager.removeSeat(new Point(388, 200), 60);
        super.dispose();
    }

    private function initPetPyramidChallenge():void {
    }

    private function onItemGiven(param1:ItemEvent):void {
        var _loc2_:Parser_1051 = param1.content;
        if (_loc2_.cmdId == 1162) {
            ItemUtil.showItemVec(_loc2_.itemDes);
            this._petPyramidAnn = _map.libManager.getMovieClip("PetPyramidAnimationMc");
            this._petPyramidAnn.x = 488;
            this._petPyramidAnn.y = 267;
            _map.front.addChild(this._petPyramidAnn);
            this._petPyramidAnn.addEventListener(Event.ENTER_FRAME, this.onAnnEnterFrame);
        }
    }

    private function onAnnEnterFrame(param1:Event):void {
        if (this._petPyramidAnn.currentFrame == this._petPyramidAnn.totalFrames) {
            this._petPyramidAnn.removeEventListener(Event.ENTER_FRAME, this.onAnnEnterFrame);
            DisplayObjectUtil.removeFromParent(this._petPyramidAnn);
            this._petPyramidAnn.stop();
        }
    }

    private function onPetPyramidBtnClick(param1:MouseEvent):void {
        if (this.isPetPyramidTime()) {
            if (ActorManager.actorInfo.highestPetLevel < 15) {
                AlertManager.showAlert("你再去练练才能参加挑战（精灵等级大于15级）");
            } else {
                ModuleManager.toggleModule(URLUtil.getAppModule("PetPyramidChallengePanel"), "正在精灵金字塔挑战面板");
            }
        } else {
            AlertManager.showAlert("金字塔挑战开启时间周五、六、日15:00-24:00");
        }
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_235);
    }

    private function isPetPyramidTime():Boolean {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * DateUtil.MILLISECONDS_PER_SECOND);
        if (_loc1_.day == 5 || _loc1_.day == 6 || _loc1_.day == 0) {
            if (_loc1_.hours >= 15 && _loc1_.hours <= 24) {
                return true;
            }
        }
        return false;
    }

    private function disposePetPyramidChallenge():void {
        ItemManager.removeEventListener1(ItemEvent.SERVER_ITEM_GIVEN, this.onItemGiven);
        if (this._petPyramidAnn) {
            this._petPyramidAnn.removeEventListener(Event.ENTER_FRAME, this.onAnnEnterFrame);
            this._petPyramidAnn = null;
        }
    }

    private function initTwoYearNpcHandle(param1:LogicEvent = null):void {
        var evt:LogicEvent = param1;
        this._oldNpc = MobileManager.getMobile(6, MobileType.NPC);
        if (this._oldNpc) {
            this._oldNpc.visible = false;
        }
        DayLimitListManager.getDaylimitList(this.DAY_LIST, function (param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            if (info.getCount(DAY_LIST[1]) > 0 && info.getCount(DAY_LIST[0]) == 0) {
                if (!MobileManager.getMobile(6, MobileType.NPC)) {
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
        this._oldNpc = MobileManager.getMobile(6, MobileType.NPC);
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
            NpcDialog.show(6, "克拉克", [[0, "哇！你也选择支持我吗？那我就又能多一票了！~真开心，不过我还想要获得更多的人气~~~~"]], ["我来帮教官拉票吧！"], [function ():void {
                NpcDialog.show(6, "克拉克", [[0, "好呀好呀！~难得你这么热心~~~那你就带着我的徽章去各处替我宣传宣传吧~~嘿嘿！~~记得去人多的地方噢~~去跑个5分钟什么的"]], ["好哒！"], [function ():void {
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
}
}
