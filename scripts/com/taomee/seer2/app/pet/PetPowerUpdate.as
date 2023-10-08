package com.taomee.seer2.app.pet
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.NumberUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import org.taomee.manager.EventManager;
   import org.taomee.utils.Tick;
   
   public class PetPowerUpdate
   {
      
      public static const PET_RE_COUNT:String = "PetReCount";
      
      public static const PET_UPDATE:String = "PetUpdate";
      
      private static var _allPower:int;
       
      
      public function PetPowerUpdate()
      {
         super();
      }
      
      public static function setup() : void
      {
         allPowerCount();
         EventManager.addEventListener(PET_RE_COUNT,onPetReCount);
         EventManager.addEventListener(PET_UPDATE,onPetUpdate);
      }
      
      private static function onPetReCount(param1:Event) : void
      {
         allPowerCount();
      }
      
      private static function onPetUpdate(param1:Event) : void
      {
         var item:PetInfo = null;
         var addNum:int = 0;
         var tipSp:Sprite = null;
         var powerTip:MovieClip = null;
         var numList:Vector.<int> = null;
         var numMC:MovieClip = null;
         var i:int = 0;
         var evt:Event = param1;
         var curAllPower:int = 0;
         var petList:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         for each(item in petList)
         {
            curAllPower += PetInfoManager.getPowerByPetInfo(item);
         }
         if(curAllPower > _allPower)
         {
            addNum = curAllPower - _allPower;
            tipSp = new Sprite();
            powerTip = UIManager.getMovieClip("PowerTip");
            powerTip.x = 0;
            powerTip.y = 0;
            tipSp.addChild(powerTip);
            numList = NumberUtil.parseNumberToDigitVec(addNum);
            i = 0;
            while(i < numList.length)
            {
               numMC = UIManager.getMovieClip("PetPowerNum");
               numMC.gotoAndStop(numList[i] + 1);
               numMC.x = 142 + 23 * i;
               numMC.y = 18;
               tipSp.addChild(numMC);
               i++;
            }
            LayerManager.topLayer.addChild(tipSp);
            tipSp.x = (1200 - tipSp.width) / 2;
            tipSp.y = (660 - tipSp.height) / 2 - 150;
            tipSp.alpha = 0.3;
            TweenNano.to(tipSp,0.5,{
               "alpha":1,
               "onComplete":function():void
               {
                  Tick.instance.addRender(function onTipShow(param1:int):void
                  {
                     var val:int = param1;
                     Tick.instance.removeRender(onTipShow);
                     TweenNano.to(tipSp,0.5,{
                        "alpha":0,
                        "onComplete":function():void
                        {
                           DisplayObjectUtil.removeFromParent(tipSp);
                        }
                     });
                  },1000);
               }
            });
         }
         _allPower = curAllPower;
      }
      
      public static function allPowerCount() : void
      {
         var _loc2_:PetInfo = null;
         var _loc1_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         _allPower = 0;
         for each(_loc2_ in _loc1_)
         {
            _allPower += PetInfoManager.getPowerByPetInfo(_loc2_);
         }
      }
   }
}
