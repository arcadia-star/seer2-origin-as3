package com.taomee.seer2.app.plantSystem {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.PlantBubbleConfig;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.plant.PlantScene;
import com.taomee.seer2.app.plant.data.PlantInfo;
import com.taomee.seer2.app.plantSystem.bubble.PlantBubble;
import com.taomee.seer2.app.plantSystem.tip.PlantTipManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
import com.taomee.seer2.app.quest.animation.QuestCompleteAnimation;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.PlantLoader;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.system.ApplicationDomain;
import flash.utils.IDataInput;

import org.taomee.manager.EventManager;
import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;
import org.taomee.utils.Tick;

public class PlantLand {


    private const homeLevelList:Vector.<uint> = Vector.<uint>([1, 2, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 12, 12, 12]);

    private const homeVipLevelList:Vector.<uint> = Vector.<uint>([0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4]);

    private const vipList:Vector.<uint> = Vector.<uint>([2, 6, 11]);

    private const gf:GlowFilter = new GlowFilter(16777113, 1, 20, 20, 2, 1, true);

    private var _mc:MovieClip;

    private var _info:PlantInfo;

    private var _seedMC:MovieClip;

    private var _plantSetInfo:PlantSetInfo;

    private var _action:uint;

    private var _load:DevilLoad;

    private var _showComplete:PlantShowComplete;

    private var _initIndex:uint;

    private var _bubble:PlantBubble;

    public function PlantLand(param1:MovieClip, param2:PlantInfo, param3:DevilLoad) {
        super();
        this._mc = param1;
        this._info = param2;
        this._load = param3;
        this._initIndex = 0;
        this.startSeed();
        this.updateLand();
        this.updateMouse();
        this.initBubble();
    }

    private function updateLand():void {
        if (this._info.plantIsOpen) {
            this._mc.gotoAndStop(2);
        } else {
            this._mc.gotoAndStop(1);
        }
    }

    private function initBubble():void {
        this._bubble = new PlantBubble();
        this._bubble.x = this._mc.x + 40;
        this._bubble.y = this._mc.y - 80;
        LayerManager.mapLayer.addChild(this._bubble);
    }

    public function setBubble(param1:uint):void {
        this._bubble.content = PlantBubbleConfig.getStr(param1);
    }

    public function startSeed():void {
        if (this._info.plantSeedId != 0) {
            PlantLoader.load(URLUtil.getRes("plant/seedItem/" + this._info.plantSeedId + ".swf"), LoadType.DOMAIN, this.onResLoaded);
        } else if (this._info.plantIsOpen == 0 && SceneManager.active.mapID == ActorManager.actorInfo.id) {
            if (this._mc.hasEventListener(MouseEvent.CLICK)) {
                return;
            }
            this._mc.addEventListener(MouseEvent.CLICK, this.onGet);
        } else if (this._info.plantIsOpen == 1 && SceneManager.active.mapID == ActorManager.actorInfo.id) {
            this._mc.addEventListener(MouseEvent.CLICK, this.onMouseLand);
        }
    }

    private function onMouseLand(param1:MouseEvent):void {
        if (this._info.plantSeedId == 0 && PlantMouse.isMouse == false) {
            param1.stopImmediatePropagation();
            ModuleManager.toggleModule(URLUtil.getAppModule("PlantLibraryPanel"), "正在打开仓库...");
        }
    }

    private function onResLoaded(param1:ContentInfo):void {
        DisplayUtil.removeForParent(this._seedMC);
        this._seedMC = DomainUtil.getMovieClip("item", param1.content as ApplicationDomain);
        this._seedMC.x = this._mc.x + 20;
        this._seedMC.y = this._mc.y - 70;
        this._seedMC.mouseChildren = false;
        this._seedMC.mouseEnabled = false;
        SceneManager.active.mapModel.front.addChild(this._seedMC);
        Tick.instance.addRender(this.updateTip, 3000);
        var _loc2_:String = "";
        if (this._info.plantSeedId != 0) {
            _loc2_ = ItemConfig.getItemName(this._info.plantSeedId);
        }
        PlantTipManager.addExternalTip(this._mc, this._seedMC, _loc2_, this.getTimeStr(), this._info.stageEndTime, this._info.seedInfo.harvestTime * 60);
        this.updateSeed();
    }

    private function updateTip(param1:uint):void {
        if (this._info.plantSeedId == 0) {
            return;
        }
        PlantTipManager.changeTip(this._mc, this._seedMC, ItemConfig.getItemName(this._info.plantSeedId), this.getTimeStr(), this._info.stageEndTime, this._info.seedInfo.harvestTime * 60);
    }

    private function getTimeStr():String {
        var _loc1_:String = null;
        if (this._info.seedStage == 4) {
            return "可以收获";
        }
        var _loc2_:String = "距离成熟:";
        if (uint(this._info.stageEndTime / 3600) < 10) {
            _loc1_ = "0";
        } else {
            _loc1_ = "";
        }
        _loc2_ += _loc1_ + uint(this._info.stageEndTime / 3600).toString() + ":";
        if (uint(this._info.stageEndTime % 3600 / 60) < 10) {
            _loc1_ = "0";
        } else {
            _loc1_ = "";
        }
        _loc2_ += _loc1_ + uint(this._info.stageEndTime % 3600 / 60).toString() + ":";
        if (this._info.stageEndTime % 3600 % 60 < 10) {
            _loc1_ = "0";
        } else {
            _loc1_ = "";
        }
        return _loc2_ + (_loc1_ + (this._info.stageEndTime % 3600 % 60).toString());
    }

    public function updateSeed(param1:Boolean = false):void {
        this.statusChange(param1);
    }

    public function statusChange(param1:Boolean = false):void {
        var currFrame:int = 0;
        var isFertilizer:Boolean = param1;
        if (this._seedMC == null) {
            QueueLoader.load(URLUtil.getRes("plant/seedItem/" + this._info.plantSeedId + ".swf"), LoadType.SWF, function (param1:ContentInfo):void {
                var _loc2_:int = 0;
                DisplayUtil.removeForParent(_seedMC);
                _seedMC = param1.content as MovieClip;
                _seedMC.x = _mc.x + 20;
                _seedMC.y = _mc.y - 70;
                _seedMC.mouseChildren = false;
                _seedMC.mouseEnabled = false;
                SceneManager.active.mapModel.front.addChildAt(_seedMC, 0);
                if (_info.seedStage != 1 && _initIndex != 0) {
                    _loc2_ = _seedMC.currentFrame;
                    if (_seedMC.totalFrames == 4) {
                        _seedMC.gotoAndStop(_loc2_);
                    } else {
                        _seedMC.gotoAndPlay(_loc2_);
                    }
                    ++_initIndex;
                } else {
                    ++_initIndex;
                    if (_seedMC.totalFrames == 4) {
                        _seedMC.gotoAndStop(_info.seedStage);
                    } else {
                        _seedMC.gotoAndStop("stage" + _info.seedStage);
                    }
                }
                if (_info.seedStage == 4) {
                    _mc.removeEventListener(MouseEvent.CLICK, onGet);
                    _mc.addEventListener(MouseEvent.CLICK, onGet);
                    _seedMC.removeEventListener(MouseEvent.CLICK, onGet);
                    _seedMC.addEventListener(MouseEvent.CLICK, onGet);
                }
            });
        } else {
            if (this._seedMC.currentLabels.length == 0 && this._seedMC.totalFrames != 4) {
                QueueLoader.load(URLUtil.getRes("plant/seedItem/" + this._info.plantSeedId + ".swf"), LoadType.SWF, this.onResLoaded);
                return;
            }
            if (this._info.seedStage != 1 && this._initIndex != 0 && isFertilizer == false) {
                currFrame = this._seedMC.currentFrame;
                if (this._seedMC.totalFrames == 4) {
                    this._seedMC.gotoAndStop(currFrame);
                } else {
                    this._seedMC.gotoAndPlay(currFrame);
                }
                ++this._initIndex;
            } else {
                ++this._initIndex;
                if (this._seedMC.totalFrames == 4) {
                    this._seedMC.gotoAndStop(this._info.seedStage);
                } else {
                    this._seedMC.gotoAndStop("stage" + this._info.seedStage);
                }
            }
            if (this._info.seedStage == 4) {
                this._mc.removeEventListener(MouseEvent.CLICK, this.onGet);
                this._mc.addEventListener(MouseEvent.CLICK, this.onGet);
                this._seedMC.removeEventListener(MouseEvent.CLICK, this.onGet);
                this._seedMC.addEventListener(MouseEvent.CLICK, this.onGet);
            }
        }
    }

    private function onGet(param1:MouseEvent):void {
        var s:String = null;
        var event:MouseEvent = param1;
        if (SceneManager.active.mapID != ActorManager.actorInfo.id) {
            this.steal();
            return;
        }
        if (this._info.seedStage == 4 && PlantManager.isQuest3 == false) {
            this._action = 2;
            Connection.addCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
            Connection.addErrorHandler(CommandSet.PLANT_SET_INFO_1519, this.onPlantError);
            Connection.send(CommandSet.PLANT_SET_INFO_1519, (SceneManager.active as PlantScene).mapID, this._info.plantId, 3, this._info.plantSeedId, 0);
        } else if (this._info.plantIsOpen == 0) {
            if (ActorManager.actorInfo.coins < 10000) {
                AlertManager.showConfirm("你没有足够的赛尔豆!" + "\n" + "通过小游戏赚取赛尔豆", function ():void {
                    SceneManager.changeScene(SceneType.LOBBY, 80);
                });
                return;
            }
            if (this._info.plantIsVip == 1 && VipManager.vipInfo.isVip() == false) {
                AlertManager.showConfirm("你不是VIP,要去开通VIP吗？", function ():void {
                    VipManager.navigateToPayPage();
                });
                return;
            }
            if (PlantHomeManager.getOpenCount() + PlantHomeManager.getVipOpenCount() >= PlantOpenLandStr.getLevelUint(ActorManager.actorInfo.plantLevel - 1, true)) {
                AlertManager.showConfirm("你的木屋等级不足！" + "\n" + "去木屋找多茨莫教授升级吧！");
                return;
            }
            s = "开放新的土地需要：" + "\n" + "木屋等级" + PlantOpenLandStr.getStr(PlantHomeManager.getOpenCount() + PlantHomeManager.getVipOpenCount(), false) + "级和10000赛尔豆";
            AlertManager.showConfirm(s, function ():void {
                _action = 1;
                Connection.addCommandListener(CommandSet.PLANT_SET_INFO_1519, onPlantSetInfo);
                Connection.addErrorHandler(CommandSet.PLANT_SET_INFO_1519, onPlantError);
                Connection.send(CommandSet.PLANT_SET_INFO_1519, (SceneManager.active as PlantScene).mapID, _info.plantId, 4, 0, 0);
            });
        }
    }

    private function steal():void {
        if (this._info.stealCount >= 2) {
            AlertManager.showAlert("这颗作物已经被偷取过了！");
            return;
        }
        if (this._info.seedStage == 4) {
            this._action = 3;
            Connection.addCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
            Connection.addErrorHandler(CommandSet.PLANT_SET_INFO_1519, this.onPlantError);
            Connection.send(CommandSet.PLANT_SET_INFO_1519, (SceneManager.active as PlantScene).mapID, this._info.plantId, 5, this._info.plantSeedId, 0);
        }
    }

    private function onPlantError(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
        Connection.removeErrorHandler(CommandSet.PLANT_SET_INFO_1519, this.onPlantError);
        if (param1.message.statusCode == 212) {
            AlertManager.showAlert("这个作物已经被主人收获！");
            this.removeSeed();
        }
        if (param1.message.statusCode == 219) {
            AlertManager.showAlert("这颗作物已经被偷取过了！");
        }
        if (param1.message.statusCode == 104382) {
            AlertManager.showAlert("这颗作物已经被偷取过了！");
        }
        if (param1.message.statusCode == 221) {
            AlertManager.showAlert("仓库已满");
        }
        if (param1.message.statusCode == 215) {
            AlertManager.showAlert("收获时间还没到");
        }
        if (param1.message.statusCode == 220) {
            AlertManager.showAlert("服务器正在忙");
        }
    }

    private function onPlantSetInfo(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
        Connection.removeErrorHandler(CommandSet.PLANT_SET_INFO_1519, this.onPlantError);
        var _loc2_:IDataInput = param1.message.getRawData();
        this._plantSetInfo = new PlantSetInfo(_loc2_);
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:uint = uint(_loc2_.readUnsignedInt());
        this._info.plantId = _loc5_;
        this._info.userId = _loc4_;
        this._info.parseInfo(_loc2_);
        if (this._action == 1) {
            this.setBubble(4);
            this.openPlant();
        } else if (this._action == 2) {
            this.setBubble(3);
            this.removeSeed();
            this.showComplete();
            this.openLand();
        } else if (this._action == 3) {
            this.setBubble(5);
            this._info.stealCount += 1;
            this.showComplete();
        }
    }

    private function openLand():void {
        this._mc.removeEventListener(MouseEvent.CLICK, this.onMouseLand);
        if (this._seedMC) {
            this._seedMC.removeEventListener(MouseEvent.CLICK, this.onGet);
        }
        if (this._info.plantIsOpen == 1 && SceneManager.active.mapID == ActorManager.actorInfo.id) {
            this._mc.addEventListener(MouseEvent.CLICK, this.onMouseLand);
            if (this._seedMC) {
                this._seedMC.addEventListener(MouseEvent.CLICK, this.onGet);
            }
        }
    }

    private function openPlant():void {
        var animation:MovieClip = null;
        animation = this._load.getMC("openPlant");
        animation.x = PlantManager._pointList[this._info.plantId].x - 10;
        animation.y = PlantManager._pointList[this._info.plantId].y + 11;
        LayerManager.topLayer.addChild(animation);
        MovieClipUtil.playMc(animation, 2, animation.totalFrames, function ():void {
            DisplayUtil.removeForParent(animation);
            updateLand();
        }, true);
    }

    private function showComplete():void {
        var list:Vector.<uint> = this._plantSetInfo.addSwapIdList;
        var countList:Vector.<uint> = this._plantSetInfo.addSwapCountList;
        if (this._showComplete) {
            this._showComplete.dispose();
        }
        this._showComplete = new PlantShowComplete(list, countList, this._mc);
        ServerBufferManager.getServerBuffer(100014, function (param1:ServerBuffer):void {
            var _loc4_:Object = null;
            var _loc5_:QuestCompleteAnimation = null;
            var _loc2_:int = 6;
            var _loc3_:int = 0;
            while (_loc3_ < 6) {
                (_loc4_ = new Object())["task_id"] = param1.readDataAtPostion(_loc2_);
                _loc4_["step_id"] = param1.readDataAtPostion(++_loc2_);
                _loc4_["task_status"] = param1.readDataAtPostion(++_loc2_);
                _loc2_++;
                if (_loc4_["task_id"] == 10) {
                    if (_loc4_["task_status"] == 0) {
                        (_loc5_ = new QuestCompleteAnimation(1)).play();
                        ServerBufferManager.updataSvrExpandBuffer(100014, 10, 0);
                    }
                    EventManager.dispatchEvent(new Event("DiamondTaskEvent"));
                }
                _loc3_++;
            }
        }, false);
    }

    private function updateMouse():void {
        this._mc.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
        this._mc.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
    }

    private function onOver(param1:MouseEvent):void {
        this._mc.filters = [this.gf];
    }

    private function onOut(param1:MouseEvent):void {
        this._mc.filters = [];
    }

    public function removeSeed():void {
        PlantLoader.cancel(URLUtil.getRes("plant/seedItem/" + this._info.plantSeedId + ".swf"), this.onResLoaded);
        DisplayUtil.removeForParent(this._seedMC);
        this._info.parseInit(this._info.plantId);
        this._info.plantIsOpen = 1;
        Tick.instance.removeRender(this.updateTip);
        if (this._seedMC) {
            PlantTipManager.remove(this._mc, this._seedMC);
        }
        if (this._mc) {
            this._mc.removeEventListener(MouseEvent.CLICK, this.onGet);
        }
        this._seedMC = null;
    }

    public function dispose():void {
        this._initIndex = 0;
        if (this._bubble) {
            this._bubble.dispose();
        }
        DisplayUtil.removeForParent(this._bubble);
        this.removeSeed();
    }

    public function openPlantMouse():void {
        if (this._info.plantIsOpen == 0 || this._info.seedStage == 4) {
            this._mc.addEventListener(MouseEvent.CLICK, this.onGet);
            if (this._seedMC) {
                this._seedMC.addEventListener(MouseEvent.CLICK, this.onGet);
            }
        }
    }

    public function closePlantMouse():void {
        this._mc.removeEventListener(MouseEvent.CLICK, this.onGet);
        if (this._seedMC) {
            this._seedMC.removeEventListener(MouseEvent.CLICK, this.onGet);
        }
    }

    public function get mc():MovieClip {
        return this._mc;
    }

    public function get info():PlantInfo {
        return this._info;
    }
}
}
