package com.taomee.seer2.app.dragonPanel
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Mouse;
   import flash.utils.IDataInput;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class DragonGameStart extends Sprite
   {
       
      
      private var _libs:ResourceLibrary;
      
      private var _itemTxt:TextField;
      
      private var _dragonTxt:TextField;
      
      private var _sorr:MovieClip;
      
      private const swapList:Vector.<uint> = Vector.<uint>([1441,1428,1429,1430,1431,1432]);
      
      private var _count:uint;
      
      private var _mainUI:MovieClip;
      
      private var _pai:MovieClip;
      
      private var _currType:int;
      
      private var _time:uint;
      
      private var _timeCount:uint;
      
      private var _timeOut:uint;
      
      private var _isStop:Boolean;
      
      private var _downList:Vector.<com.taomee.seer2.app.dragonPanel.DragonDownItem>;
      
      private var _closeBtn:SimpleButton;
      
      private var _tipMC:MovieClip;
      
      private var _goBtn:SimpleButton;
      
      private var _startTimeOut:uint;
      
      public function DragonGameStart(param1:ResourceLibrary, param2:uint)
      {
         super();
         this._libs = param1;
         this._count = param2;
         this.initMC();
         this.updateStatus();
      }
      
      private function initMC() : void
      {
         this._mainUI = this.getMcFromLib("mainUI");
         addChild(this._mainUI);
         this._itemTxt = this._mainUI["itemTxt"];
         this._dragonTxt = this._mainUI["dragonTxt"];
         this._sorr = this._mainUI["sorr"];
         this._pai = this._mainUI["pai"];
         this._closeBtn = this._mainUI["closeBtn"];
         this._tipMC = this._mainUI["tipMC"];
         this._goBtn = this._mainUI["goBtn"];
         this._tipMC.visible = true;
         this._isStop = false;
         this._pai.mouseChildren = false;
         this._pai.mouseEnabled = false;
         this._downList = Vector.<com.taomee.seer2.app.dragonPanel.DragonDownItem>([]);
         this._time = 2500;
         this._goBtn.visible = true;
         this._goBtn.addEventListener(MouseEvent.CLICK,this.onGo);
         this.initEvent();
      }
      
      private function onGo(param1:MouseEvent) : void
      {
         clearTimeout(this._startTimeOut);
         this.onStart();
      }
      
      private function initEvent() : void
      {
         this._closeBtn.mouseEnabled = false;
         this._startTimeOut = setTimeout(function():void
         {
            onStart();
         },9000);
      }
      
      private function onStart() : void
      {
         Mouse.hide();
         this._goBtn.visible = false;
         this._tipMC.visible = false;
         this._closeBtn.mouseEnabled = true;
         this._mainUI.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._closeBtn.addEventListener(MouseEvent.CLICK,this.onClose);
         this.startTimeOut();
      }
      
      private function startTimeOut() : void
      {
         this._timeOut = setTimeout(this.onTime,this._time);
      }
      
      private function onTime() : void
      {
         if(this._isStop)
         {
            return;
         }
         ++this._timeCount;
         if(this._timeCount >= 7 && this._timeCount < 15)
         {
            this._time = 1500;
         }
         else if(this._timeCount >= 15 && this._timeCount < 30)
         {
            this._time = 1200;
         }
         else if(this._timeCount >= 30)
         {
            this._time = 1000;
         }
         this.itemDown();
         this.startTimeOut();
      }
      
      private function itemDown() : void
      {
         this._currType = this.typeRan();
         var _loc1_:com.taomee.seer2.app.dragonPanel.DragonDownItem = new com.taomee.seer2.app.dragonPanel.DragonDownItem(this._currType,this._libs);
         this._mainUI.addChild(_loc1_);
         this._downList.push(_loc1_);
         this.dragonPoint(_loc1_);
      }
      
      private function dragonPoint(param1:com.taomee.seer2.app.dragonPanel.DragonDownItem) : void
      {
         var _loc2_:Number = Math.random() * 700;
         param1.x = _loc2_;
         param1.y = -50;
      }
      
      private function typeRan() : uint
      {
         var _loc1_:Number = Math.random() * 100;
         if(_loc1_ <= 15)
         {
            return this.typeRan2();
         }
         if(_loc1_ > 15 && _loc1_ <= 20)
         {
            return 2;
         }
         if(_loc1_ > 20 && _loc1_ <= 50)
         {
            return 3;
         }
         if(_loc1_ > 50 && _loc1_ <= 70)
         {
            return 4;
         }
         return 5;
      }
      
      private function typeRan2() : uint
      {
         var _loc1_:Number = Math.random() * 100;
         if(_loc1_ < 20)
         {
            return 0;
         }
         return 1;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var dragon:com.taomee.seer2.app.dragonPanel.DragonDownItem = null;
         var event:Event = param1;
         if(this._isStop)
         {
            return;
         }
         this._pai.x = this._mainUI.mouseX;
         this._pai.y = this._mainUI.mouseY;
         for each(dragon in this._downList)
         {
            if(dragon.y >= 526)
            {
               dragon.dispose();
               DisplayUtil.removeForParent(dragon);
               this._downList.splice(this._downList.indexOf(dragon),1);
            }
            else if(this._pai["hitTest"].hitTestObject(dragon))
            {
               dragon.hitTestO(this._pai["hitTest"],dragon.type,function():void
               {
                  DisplayUtil.removeForParent(dragon);
               });
               this._downList.splice(this._downList.indexOf(dragon),1);
               SwapManager.swapItem(this.swapList[dragon.type],1,function(param1:IDataInput):void
               {
                  var _loc2_:SwapInfo = new SwapInfo(param1,false);
                  --_count;
                  if(dragon.type == 2)
                  {
                     ++_count;
                  }
                  else if(dragon.type == 0)
                  {
                     if(PetInfoManager.getFirstPetInfo().hp == 0)
                     {
                        Connection.addCommandListener(CommandSet.TREAT_ALL_PET_1215,onAddAllPetBlood);
                        Connection.send(CommandSet.TREAT_ALL_PET_1215);
                     }
                     else
                     {
                        onHide();
                        if(_count < 9)
                        {
                           _count = 0;
                        }
                        else
                        {
                           _count -= 9;
                        }
                        FightManager.startFightWithWild(442);
                     }
                  }
                  else
                  {
                     ServerMessager.addMessage("获得了" + ItemConfig.getItemDefinition(_loc2_.addSwapIdList[0]).name);
                  }
                  updateStatus();
               });
               break;
            }
         }
      }
      
      private function onAddAllPetBlood(param1:MessageEvent) : void
      {
         var _loc3_:PetInfo = null;
         var _loc4_:int = 0;
         Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215,this.onAddAllPetBlood);
         var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         for each(_loc3_ in _loc2_)
         {
            _loc3_.hp = _loc3_.maxHp;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE,_loc3_);
         }
         _loc4_ = int(param1.message.getRawData().readUnsignedInt());
         ActorManager.actorInfo.coins = _loc4_;
         this.onHide();
         if(this._count < 9)
         {
            this._count = 0;
         }
         else
         {
            this._count -= 9;
         }
         FightManager.startFightWithWild(442);
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         Mouse.show();
         this._isStop = true;
         AlertManager.showConfirm("你确定结束这次捕蜻蜓了吗？",function():void
         {
            onHide();
         },function():void
         {
            Mouse.hide();
            clearTimeout(_timeOut);
            startTimeOut();
            _isStop = false;
         });
      }
      
      private function onHide() : void
      {
         var _loc1_:com.taomee.seer2.app.dragonPanel.DragonDownItem = null;
         Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215,this.onAddAllPetBlood);
         this._isStop = true;
         clearTimeout(this._timeOut);
         clearTimeout(this._startTimeOut);
         DisplayObjectUtil.removeFromParent(this._mainUI);
         for each(_loc1_ in this._downList)
         {
            _loc1_.dispose();
            DisplayUtil.removeForParent(_loc1_);
         }
         LayerManager.showMap();
         Mouse.show();
         this._mainUI.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function updateStatus() : void
      {
         var _loc1_:int = ItemManager.getItemQuantityByReferenceId(400299);
         if(this._count % 10 > 0)
         {
            this._itemTxt.text = String(int(this._count / 10));
         }
         else
         {
            this._itemTxt.text = String(int(this._count / 10) - 1);
         }
         if(this._count % 10 > 0)
         {
            this._sorr.scaleX = this._count % 10 * 0.1;
         }
         else if(this._count == 0)
         {
            this._sorr.scaleX = 0;
         }
         else
         {
            this._sorr.scaleX = 1;
         }
         this._dragonTxt.text = _loc1_.toString();
         if(this._count <= 0)
         {
            this._isStop = true;
            this.onHide();
            ModuleManager.toggleModule(URLUtil.getAppModule("DragonTipPanel"),"正在打开...");
         }
      }
      
      private function getMcFromLib(param1:String) : MovieClip
      {
         return this._libs.getMovieClip(param1) as MovieClip;
      }
   }
}
