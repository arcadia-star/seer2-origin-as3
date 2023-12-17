package com.taomee.seer2.app.activity.processor
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.morphSystem.MorphManager;
   import com.taomee.seer2.app.morphSystem.MorphSwitch;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class FoodAct
   {
      
      public static var dressCacheId:int;
       
      
      private const PET_LIMIT:int = 202234;
      
      private const FIGHT_INDEX:int = 418;
      
      private const PET_LIST:Vector.<int> = Vector.<int>([3006,3007,3008,3009,3010,3011]);
      
      private const FOOD_FALL:Array = [[400,110],[365,140],[435,110]];
      
      private const HERE_POS:Array = [[400,250],[365,280],[435,280]];
      
      private var _guo:MovieClip;
      
      private var _set:MovieClip;
      
      private var _vip:MovieClip;
      
      private var _changeOkTip:MovieClip;
      
      private var _cookingTip:MovieClip;
      
      private var _selfTip:MovieClip;
      
      private var _getGiftTip:MovieClip;
      
      private var _getPetTip:MovieClip;
      
      private var _resLib:ApplicationDomain;
      
      private var _mapModel:MapModel;
      
      private var _curModelId:uint;
      
      private var _guoState:int;
      
      private var _petNum:int;
      
      private var _isUpdateInfo:Boolean;
      
      private var _petNpc:MovieClip;
      
      private var _idList:Vector.<int>;
      
      public function FoodAct(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this.getURL();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_446);
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("foodAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
      }
      
      private function init() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
         this._guo = this._mapModel.content["guo"];
         this._set = this._mapModel.content["changeSet"];
         this._vip = this._mapModel.content["vip"];
         this._vip.buttonMode = true;
         this._set.buttonMode = true;
         this._guo.buttonMode = true;
         this._guo.addEventListener(MouseEvent.CLICK,this.askGoGuo);
         this._set.addEventListener(MouseEvent.CLICK,this.onSet);
         this._vip.addEventListener(MouseEvent.CLICK,this.onVip);
         TooltipManager.addCommonTip(this._vip,"加入VIP有更高几率看见我哦！");
         if(FoodAct.dressCacheId != 0)
         {
            ActorManager.actorInfo.morphInfo.morphId = FoodAct.dressCacheId;
            MorphManager.startThisMorph(ActorManager.actorInfo.morphInfo.morphId);
         }
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeByte(0);
         Connection.send(CommandSet.CLI_ASK_CHUANGO_INFO_1249,_loc1_);
         Connection.addCommandListener(CommandSet.CLI_ASK_CHUANGO_INFO_1249,this.updateGuo);
         Connection.addCommandListener(CommandSet.CLI_ASK_TO_DRESS_UP_1247,this.onDressUp);
         Connection.addCommandListener(CommandSet.CLI_ASK_TO_ENTER_CHUANGO_1248,this.onAskGoGuo);
         this.petUpdate();
      }
      
      private function onSwitch(param1:SceneEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == this.FIGHT_INDEX)
         {
            this.removePet();
            this._petNum = 0;
         }
         if(SceneManager.prevMapID == 1421 && SceneManager.active.type != SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
            Connection.removeCommandListener(CommandSet.CLI_ASK_TO_DRESS_UP_1247,this.onDressUp);
            Connection.removeCommandListener(CommandSet.CLI_ASK_TO_ENTER_CHUANGO_1248,this.onAskGoGuo);
            MorphManager.removeMorph(ActorManager.getActor());
         }
      }
      
      private function isInActTime() : Boolean
      {
         if(Boolean(DateUtil.isInHourScope(13,15,0,0) || DateUtil.isInHourScope(18,20,0,0)))
         {
            return true;
         }
         return false;
      }
      
      private function addPet() : void
      {
         this.removePet();
         this._petNpc = this.getMovie("Pet");
         this._petNpc.buttonMode = true;
         this._petNpc.scaleX = -1;
         this._petNpc.x = 505;
         this._petNpc.y = 23;
         this._mapModel.content.addChild(this._petNpc);
         this._petNpc.addEventListener(MouseEvent.CLICK,this.onPetClick);
      }
      
      private function removePet() : void
      {
         if(this._petNpc)
         {
            this._petNpc.removeEventListener(MouseEvent.CLICK,this.onPetClick);
            DisplayUtil.removeForParent(this._petNpc);
            this._petNpc = null;
         }
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function onPetClick(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(this.FIGHT_INDEX);
      }
      
      private function otherChange(param1:MessageEvent) : void
      {
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:int = int(_loc2_.readUnsignedInt());
         var _loc5_:RemoteActor;
         if(_loc5_ = ActorManager.getRemoteActor(_loc3_))
         {
            MorphManager.startRemoteMorph(_loc4_,_loc5_);
         }
      }
      
      private function updateGuo(param1:MessageEvent) : void
      {
         var i:int = 0;
         var frame:int = 0;
         var tempActor:Actor = null;
         var index3:int = 0;
         var tpList:Vector.<int> = null;
         var addId:int = 0;
         var removeId:int = 0;
         var actor:Actor = null;
         var addId1:int = 0;
         var removeId1:int = 0;
         var actor1:Actor = null;
         var evt:MessageEvent = param1;
         var data:ByteArray = evt.message.getRawDataCopy();
         var _curGuoState:int = data.readByte();
         if(!this._idList)
         {
            this._idList = new Vector.<int>();
            this._idList.push(data.readUnsignedInt(),data.readUnsignedInt(),data.readUnsignedInt());
            this._guoState = _curGuoState;
            i = 0;
            while(i < this._idList.length)
            {
               if(this._idList[i] != 0)
               {
                  if(this._idList[i] == ActorManager.actorInfo.id)
                  {
                     this.showPlayerHandle(this._idList[i],false);
                  }
                  if(ActorManager.getRemoteActor(this._idList[i]))
                  {
                     this.showPlayerHandle(this._idList[i],false);
                  }
               }
               i++;
            }
            if(this._guoState == 1)
            {
               this.addCookingTip();
            }
            else
            {
               this.removeCookingTip();
            }
            i = 0;
            while(i < 3)
            {
               if(this._idList[i] != 0)
               {
                  frame = 2;
                  tempActor = ActorManager.getActorById(this._idList[i]);
                  if(tempActor)
                  {
                     if(tempActor.getInfo().morphInfo.morphId != 0)
                     {
                        index3 = this.PET_LIST.indexOf(tempActor.getInfo().morphInfo.morphId);
                        if(index3 != -1)
                        {
                           this.updateGuoFoodState(i,frame,index3 + 1);
                        }
                        else
                        {
                           this.updateGuoFoodState(i,frame,i + 1);
                        }
                     }
                     else
                     {
                        this.updateGuoFoodState(i,frame,i + 1);
                     }
                  }
               }
               else
               {
                  frame = 1;
                  this.updateGuoFoodState(i,frame);
               }
               i++;
            }
            ActiveCountManager.requestActiveCount(this.PET_LIMIT,function(param1:uint, param2:uint):void
            {
               _petNum = param2;
               if(_petNum > 0)
               {
                  addPet();
               }
               else
               {
                  removePet();
               }
            });
            this.selfHereTipHandle(this._idList);
         }
         else
         {
            tpList = new Vector.<int>();
            tpList.push(data.readUnsignedInt(),data.readUnsignedInt(),data.readUnsignedInt());
            if(_curGuoState == 0 && this._guoState == 0)
            {
               this.removeCookingTip();
               if(this.getIdListLength(tpList) > this.getIdListLength(this._idList))
               {
                  addId = this.getAddGuoUid(tpList,this._idList);
                  this._idList = tpList;
                  this.beforeGuoEffect(addId);
               }
               if(this.getIdListLength(tpList) < this.getIdListLength(this._idList))
               {
                  removeId = this.getRemoveGuoUid(this._idList,tpList);
                  this.updateGuoFoodState(this._idList.indexOf(removeId),1);
                  this._idList = tpList;
                  actor = ActorManager.getActorById(removeId);
                  if(actor)
                  {
                     actor.isShow = true;
                  }
               }
            }
            if(_curGuoState == 0 && this._guoState == 1)
            {
               this.removeCookingTip();
               this._guoState = 0;
               i = 0;
               while(i < 3)
               {
                  this.updateGuoFoodState(i,1);
                  i++;
               }
               i = 0;
               while(i < this._idList.length)
               {
                  if(this._idList[i] != 0)
                  {
                     this.showPlayerHandle(this._idList[i],true);
                  }
                  i++;
               }
               if(this._idList.indexOf(ActorManager.actorInfo.id) != -1)
               {
                  this.addGetGiftTip();
                  this.petUpdate(true);
               }
               this._idList = new Vector.<int>();
               this.selfHereTipHandle(this._idList);
            }
            if(_curGuoState == 1)
            {
               if(this._guoState == 0)
               {
                  this._guoState = 1;
                  if(this.getIdListLength(tpList) > this.getIdListLength(this._idList))
                  {
                     addId1 = this.getAddGuoUid(tpList,this._idList);
                     this._idList = tpList;
                     this.beforeGuoEffect(addId1,true);
                  }
               }
               else
               {
                  this.addCookingTip();
                  if(this.getIdListLength(tpList) > this.getIdListLength(this._idList))
                  {
                  }
               }
               if(this.getIdListLength(tpList) < this.getIdListLength(this._idList))
               {
                  removeId1 = this.getRemoveGuoUid(this._idList,tpList);
                  this.updateGuoFoodState(this._idList.indexOf(removeId1),1);
                  this._idList = tpList;
                  actor1 = ActorManager.getActorById(removeId1);
                  if(actor1)
                  {
                     actor1.isShow = true;
                  }
               }
            }
         }
         this._isUpdateInfo = true;
      }
      
      private function petUpdate(param1:Boolean = false) : void
      {
         var hasAnimation:Boolean = param1;
         ActiveCountManager.requestActiveCount(this.PET_LIMIT,function(param1:uint, param2:uint):void
         {
            _petNum = param2;
            if(_petNum > 0)
            {
               if(hasAnimation)
               {
                  addGetPetTip();
               }
               else
               {
                  addPet();
               }
            }
            else
            {
               removePet();
            }
         });
      }
      
      private function selfHereTipHandle(param1:Vector.<int>) : void
      {
         var _loc2_:int = param1.indexOf(ActorManager.actorInfo.id);
         if(_loc2_ != -1)
         {
            this.addSelfTip(this.HERE_POS[_loc2_]);
         }
         else
         {
            this.removeSelfTip();
         }
      }
      
      private function addSelfTip(param1:Array) : void
      {
         this.removeSelfTip();
         this._selfTip = this.getMovie("GuoSelfTip");
         this._mapModel.content.addChild(this._selfTip);
         this._selfTip.x = param1[0];
         this._selfTip.y = param1[1];
      }
      
      private function removeSelfTip() : void
      {
         DisplayUtil.removeForParent(this._selfTip);
         this._selfTip = null;
      }
      
      private function onSet(param1:MouseEvent) : void
      {
         if(!this.isInActTime())
         {
            AlertManager.showAlert("不在活动时间内，请到时间再来吧!");
            return;
         }
         if(!this._isUpdateInfo)
         {
            return;
         }
         if(this._idList)
         {
            if(this._idList.indexOf(ActorManager.actorInfo.id) != -1)
            {
               AlertManager.showAlert("你已在锅中，不可变身哦!");
               return;
            }
         }
         Connection.send(CommandSet.CLI_ASK_TO_DRESS_UP_1247);
      }
      
      private function onVip(param1:MouseEvent) : void
      {
         VipManager.openVip();
      }
      
      private function onDressUp(param1:MessageEvent) : void
      {
         var _loc6_:int = 0;
         var _loc7_:RemoteActor = null;
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:int = int(_loc2_.readUnsignedByte());
         var _loc5_:int = int(_loc2_.readUnsignedByte());
         if(_loc4_ == 0)
         {
            if(ActorManager.actorInfo.id == _loc3_)
            {
               ServerMessager.addMessage("花费200赛尔豆变身成功!");
               if(this._guoState == 0)
               {
                  this.addChangeOkTip();
               }
               _loc6_ = int(MorphSwitch.morphSwitch(_loc5_));
               FoodAct.dressCacheId = _loc6_;
               ActorManager.actorInfo.morphInfo.morphId = MorphSwitch.morphSwitch(_loc5_);
               MorphManager.startThisMorph(_loc6_);
            }
            else if(_loc7_ = ActorManager.getRemoteActor(_loc3_))
            {
               _loc7_.getInfo().morphInfo.morphId = MorphSwitch.morphSwitch(_loc5_);
               MorphManager.startRemoteMorph(MorphSwitch.morphSwitch(_loc5_),_loc7_);
            }
         }
         else if(ActorManager.actorInfo.id == _loc3_)
         {
            AlertManager.showAlert("变身所需的赛尔豆不足哦!");
         }
      }
      
      private function addChangeOkTip() : void
      {
         this.removeChangeOkTip();
         this._changeOkTip = this.getMovie("Tip");
         this._changeOkTip.x = (1000 - this._changeOkTip.width) / 2;
         this._changeOkTip.y = 175;
         this._changeOkTip.mouseEnabled = this._changeOkTip.mouseChildren = false;
         this._mapModel.front.addChild(this._changeOkTip);
         TweenNano.delayedCall(2,this.removeChangeOkTip);
      }
      
      private function addGetGiftTip() : void
      {
         if(Boolean(this._getGiftTip) && Boolean(this._getGiftTip.parent))
         {
            DisplayUtil.removeForParent(this._getGiftTip);
            this._getGiftTip = null;
         }
         this._getGiftTip = this.getMovie("GetGiftMC");
         this._getGiftTip.x = 315;
         this._getGiftTip.y = 160;
         this._mapModel.content.addChild(this._getGiftTip);
         MovieClipUtil.playMc(this._getGiftTip,2,this._getGiftTip.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_getGiftTip);
            _getGiftTip = null;
         },true);
      }
      
      private function addGetPetTip() : void
      {
         if(Boolean(this._getPetTip) && Boolean(this._getPetTip.parent))
         {
            DisplayUtil.removeForParent(this._getPetTip);
            this._getPetTip = null;
         }
         this._getPetTip = this.getMovie("GetPetMC");
         this._getPetTip.x = 350;
         this._getPetTip.y = 250;
         this._mapModel.content.addChild(this._getPetTip);
         MovieClipUtil.playMc(this._getPetTip,2,this._getPetTip.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_getPetTip);
            _getPetTip = null;
            addPet();
         },true);
      }
      
      private function removeChangeOkTip() : void
      {
         DisplayUtil.removeForParent(this._changeOkTip);
         this._changeOkTip = null;
      }
      
      private function addCookingTip() : void
      {
         this.removeChangeOkTip();
         this._cookingTip = this.getMovie("TipZhu");
         this._cookingTip.x = 305;
         this._cookingTip.y = 343;
         this._cookingTip.mouseEnabled = this._cookingTip.mouseChildren = false;
         this._cookingTip.play();
         this._mapModel.front.addChild(this._cookingTip);
      }
      
      private function removeCookingTip() : void
      {
         DisplayUtil.removeForParent(this._cookingTip);
         this._cookingTip = null;
      }
      
      private function getAddGuoUid(param1:Vector.<int>, param2:Vector.<int>) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] != 0 && param2.indexOf(param1[_loc4_]) == -1)
            {
               _loc3_ = param1[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function getRemoveGuoUid(param1:Vector.<int>, param2:Vector.<int>) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            if(param2[_loc4_] != 0 && param1.indexOf(param2[_loc4_]) == -1)
            {
               _loc3_ = param2[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function beforeGuoEffect(param1:int, param2:Boolean = false) : void
      {
         var actor:Actor = null;
         var animation:MovieClip = null;
         var uid:int = param1;
         var isCooking:Boolean = param2;
         actor = ActorManager.getActorById(uid);
         if(actor)
         {
            actor.stop();
            animation = this.getMovie("GoGuoEffect");
            animation.mouseEnabled = animation.mouseChildren = false;
            this._mapModel.front.addChild(animation);
            animation.x = actor.x;
            animation.y = actor.y;
            MovieClipUtil.playMc(animation,2,animation.totalFrames,function():void
            {
               DisplayUtil.removeForParent(animation);
               animation = null;
               actor.isShow = false;
               foodGoGuoEffect(uid);
               if(isCooking)
               {
                  addCookingTip();
               }
            },true);
         }
      }
      
      private function foodGoGuoEffect(param1:int) : void
      {
         var petId:int;
         var index:int = 0;
         var res:MovieClip = null;
         var index1:int = 0;
         var pos:Array = null;
         var uid:int = param1;
         var actor:Actor = ActorManager.getActorById(uid);
         if(!actor)
         {
            return;
         }
         petId = int(actor.getInfo().morphInfo.morphId);
         index = this.PET_LIST.indexOf(petId);
         if(index != -1)
         {
            res = this.getMovie("GoGuo" + (index + 1));
            this._mapModel.content.addChild(res);
            index1 = this._idList.indexOf(uid);
            pos = this.FOOD_FALL[index1];
            res.x = pos[0];
            res.y = pos[1];
            MovieClipUtil.playMc(res,2,res.totalFrames,function():void
            {
               DisplayUtil.removeForParent(res);
               res = null;
               updateGuoFoodState(index1,2,index + 1);
               selfHereTipHandle(_idList);
            },true);
         }
      }
      
      private function updateGuoFoodState(param1:int, param2:int, param3:int = 1) : void
      {
         (this._guo["food_" + (param1 + 1)] as MovieClip).gotoAndStop(param2);
         if(param2 == 2)
         {
            (this._guo["food_" + (param1 + 1)]["res"] as MovieClip).gotoAndStop(param3);
         }
      }
      
      private function getIdListLength(param1:Vector.<int>) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for each(_loc3_ in param1)
         {
            if(_loc3_ != 0)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function showPlayerHandle(param1:int, param2:Boolean) : void
      {
         var _loc3_:Actor = ActorManager.getActorById(param1);
         if(_loc3_)
         {
            _loc3_.isShow = param2;
         }
      }
      
      private function askGoGuo(param1:MouseEvent) : void
      {
         var _loc2_:ByteArray = null;
         if(!this.isInActTime())
         {
            AlertManager.showAlert("不在活动时间内，请到时间再来吧!");
            return;
         }
         if(!this._isUpdateInfo)
         {
            return;
         }
         if(this.PET_LIST.indexOf(ActorManager.actorInfo.morphInfo.morphId) == -1)
         {
            AlertManager.showAlert("先点击变身装置变成美食才可以参加煮哦!");
         }
         else if(this._guoState == 1)
         {
            AlertManager.showAlert("锅正在煮，等这锅煮好了再参加吧!");
         }
         else if(this._petNum > 0)
         {
            AlertManager.showAlert("挑战完精灵再参加吧!");
         }
         else
         {
            _loc2_ = new ByteArray();
            _loc2_.writeByte(1);
            Connection.send(CommandSet.CLI_ASK_TO_ENTER_CHUANGO_1248,_loc2_);
         }
      }
      
      private function onAskGoGuo(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         if(_loc3_ == 0)
         {
         }
         Connection.removeCommandListener(CommandSet.CLI_ASK_TO_ENTER_CHUANGO_1248,this.onAskGoGuo);
      }
      
      private function removeCommand() : void
      {
         Connection.removeCommandListener(CommandSet.CLI_ASK_CHUANGO_INFO_1249,this.updateGuo);
         Connection.removeCommandListener(CommandSet.CLI_ASK_TO_DRESS_UP_1247,this.onDressUp);
         Connection.removeCommandListener(CommandSet.CLI_ASK_TO_ENTER_CHUANGO_1248,this.onAskGoGuo);
      }
      
      public function dispose() : void
      {
         this._idList = null;
         this.removeCommand();
         this._guo.removeEventListener(MouseEvent.CLICK,this.askGoGuo);
         this._set.removeEventListener(MouseEvent.CLICK,this.onSet);
         this.removeChangeOkTip();
         this.removeCookingTip();
         this.removeSelfTip();
         this.removePet();
         this._resLib = null;
         this._guo = null;
         this._set = null;
         this._mapModel = null;
      }
   }
}
