package com.taomee.seer2.app.firstTeach.guide.controller
{
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.newGuidStatistics.NewGuidStatisManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class GudieFightTipContent
   {
      
      private static var tarArr:Array = [];
      
      private static var tip:MovieClip;
      
      private static var currName:String;
      
      private static var currPar:Sprite;
      
      private static var _index:int;
      
      private static var _isClear:Boolean;
       
      
      public function GudieFightTipContent()
      {
         super();
      }
      
      public static function pushTar(param1:*, param2:int) : void
      {
         tarArr[param2] = param1;
      }
      
      public static function startTip(param1:String, param2:int, param3:* = null, param4:Boolean = false) : void
      {
         currName = param1;
         _index = param2;
         _isClear = param4;
         tip = FightUIManager.getMovieClip(param1);
         if(param3)
         {
            currPar = param3;
            param3.addChild(tip);
         }
         else
         {
            SceneManager.active.mapModel.front.addChild(tip);
         }
         tarArr[param2].addEventListener(MouseEvent.CLICK,onTar);
      }
      
      private static function onTar(param1:MouseEvent) : void
      {
         if(param1)
         {
            param1.currentTarget.removeEventListener(MouseEvent.CLICK,onTar);
         }
         DisplayUtil.removeForParent(tip);
         if(_isClear)
         {
            _index = -1;
         }
         if(_index == 1)
         {
            startTip("UI_TIP3",2,currPar);
         }
         else if(_index == 2)
         {
            startTip("UI_TIP4",3,currPar);
         }
         else if(_index == 3)
         {
            startTip("UI_TIP3",4,currPar);
         }
         else if(_index == 6)
         {
            startTip("UI_TIP7",7,currPar);
         }
         else if(_index == 5)
         {
            NewGuidStatisManager.statisHandle(9);
         }
      }
      
      public static function clearAll() : void
      {
         tarArr = [];
      }
   }
}
