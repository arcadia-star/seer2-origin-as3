package com.taomee.seer2.app.actives
{
   import com.greensock.TweenLite;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import flash.utils.setTimeout;
   import org.taomee.utils.Tick;
   
   public class DogSipaikeAct
   {
      
      private static var _instance:com.taomee.seer2.app.actives.DogSipaikeAct;
       
      
      private const PET_ID:uint = 58;
      
      private const FIGHT_ID:Array = [788,789,790];
      
      private const LEV_NUM:Array = [10,40,100];
      
      private const NAME_LIST:Array = ["lv10","lv40","lv100"];
      
      private var isProcessing:Boolean;
      
      private var leftTime:int;
      
      private var petNum:Array;
      
      private var petList:Vector.<SpawnedPet>;
      
      private var toFight:Boolean;
      
      private var tipsMc:MovieClip;
      
      private var timeTxt:TextField;
      
      private var buyPassBtn:SimpleButton;
      
      private var subIndex:int = -1;
      
      public function DogSipaikeAct()
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.actives.DogSipaikeAct
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.actives.DogSipaikeAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         this.tipsMc = SceneManager.active.mapModel.front["tipsMc"];
         this.timeTxt = SceneManager.active.mapModel.front["timeTxt"];
         this.buyPassBtn = SceneManager.active.mapModel.front["buyPassBtn"];
         this.tipsMc.visible = false;
         this.tipsMc.gotoAndStop(1);
         this.buyPassBtn.addEventListener(MouseEvent.CLICK,this.toBuy);
         this.toFight = false;
         if(!this.isProcessing)
         {
            this.subIndex = -1;
            this.leftTime = 300;
            Tick.instance.addRender(this.updateTime,1000);
            this.petNum = [4,4,2];
            this.isProcessing = true;
            this.tipsMc.gotoAndStop(1);
            this.tipsMc.x = 244;
            this.tipsMc.y = 120;
            this.tipsMc.visible = true;
            setTimeout(function():void
            {
               TweenLite.to(tipsMc,1,{"y":-70});
            },3000);
         }
         if(this.subIndex != -1)
         {
            --this.petNum[this.subIndex];
         }
         if(this.petNum[0] == 0 && this.petNum[1] == 0 && this.petNum[2] == 0)
         {
            Tick.instance.removeRender(this.updateTime);
            this.tipsMc.gotoAndStop(2);
            this.tipsMc.x = 244;
            this.tipsMc.y = 120;
            this.tipsMc.visible = true;
            setTimeout(function():void
            {
               TweenLite.to(tipsMc,1,{
                  "y":-70,
                  "onComplete":toSwap
               });
            },1000);
            this.isProcessing = false;
         }
         else
         {
            if(this.leftTime == 0)
            {
               Tick.instance.removeRender(this.updateTime);
               this.isProcessing = false;
               AlertManager.showAlert("时间到了哦!",function():void
               {
                  SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
                  SceneManager.changeScene(SceneType.LOBBY,70);
               });
               return;
            }
            this.createPet();
         }
      }
      
      protected function toBuy(param1:MouseEvent) : void
      {
         var _loc2_:BuyPropInfo = new BuyPropInfo();
         _loc2_.itemId = 603425;
         _loc2_.buyComplete = this.buyComplete;
         ShopManager.buyVirtualItem(_loc2_);
      }
      
      private function buyComplete(param1:*) : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function toSwap() : void
      {
         SwapManager.swapItem(2306,1,this.swapTaskState);
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         ModuleManager.showAppModule("SiPaiKePanel");
      }
      
      private function swapTaskState(param1:IDataInput) : void
      {
         new SwapInfo(param1);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      public function dispose() : void
      {
         if(!this.toFight)
         {
            this.isProcessing = false;
            Tick.instance.removeRender(this.updateTime);
            SwapManager.swapItem(2311);
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.petList.length)
         {
            this.petList[_loc1_].removeEventListener(MouseEvent.CLICK,this.subNum);
            _loc1_++;
         }
      }
      
      private function createPet() : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:SpawnedPet = null;
         this.petList = new Vector.<SpawnedPet>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = 0;
            while(_loc2_ < this.petNum[_loc1_])
            {
               _loc3_ = 614;
               if(this.LEV_NUM[_loc1_] > 30)
               {
                  _loc3_++;
               }
               (_loc4_ = new SpawnedPet(_loc3_,this.FIGHT_ID[_loc1_],this.LEV_NUM[_loc1_])).addEventListener(MouseEvent.CLICK,this.subNum,false,1000);
               _loc4_.mouseChildren = false;
               _loc4_.name = this.NAME_LIST[_loc1_];
               MobileManager.addMobile(_loc4_,MobileType.SPAWNED_PET);
               this.petList.push(_loc4_);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function subNum(param1:MouseEvent) : void
      {
         var _loc2_:SpawnedPet = param1.target as SpawnedPet;
         this.toFight = true;
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            if(_loc2_.name == this.NAME_LIST[_loc3_])
            {
               this.subIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
      }
      
      private function updateTime(param1:uint) : void
      {
         var n:uint = param1;
         --this.leftTime;
         if(this.leftTime <= 0)
         {
            this.leftTime = 0;
            if(SceneManager.active.type == SceneType.COPY)
            {
               Tick.instance.removeRender(this.updateTime);
               this.isProcessing = false;
               AlertManager.showAlert("时间到了哦!",function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
               });
            }
         }
         this.timeTxt.text = DateUtil.getMS(this.leftTime);
      }
   }
}
