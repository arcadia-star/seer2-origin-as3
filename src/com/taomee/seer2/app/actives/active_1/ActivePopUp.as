package com.taomee.seer2.app.actives.active_1
{
   import com.taomee.seer2.app.manager.InteractiveRewardManager;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ActivePopUp
   {
      
      private static var _onStart:Function;
      
      private static var _popUp:MovieClip;
      
      private static var _box:MovieClip;
      
      private static var _onCloseBox:Function;
       
      
      public function ActivePopUp()
      {
         super();
      }
      
      public static function popup(param1:ResourceLibrary, param2:int, param3:Function) : void
      {
         _onStart = param3;
         _popUp = param1.getMovieClip("introPanel");
         _popUp["mc"].gotoAndStop(param2);
         _popUp["startBtn"].addEventListener(MouseEvent.CLICK,onClick);
         _popUp.x = LayerManager.root.width - _popUp.width >> 1;
         _popUp.y = LayerManager.root.height - _popUp.height >> 1;
         LayerManager.topLayer.addChild(_popUp);
         param1 = null;
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         _popUp["startBtn"].removeEventListener(MouseEvent.CLICK,onClick);
         DisplayObjectUtil.removeFromParent(_popUp);
         _onStart();
         _onStart = null;
      }
      
      public static function popBox(param1:ResourceLibrary, param2:int, param3:Function) : void
      {
         var resLib:ResourceLibrary = param1;
         var id:int = param2;
         var onCloseBox:Function = param3;
         _onCloseBox = onCloseBox;
         _box = resLib.getMovieClip("box_" + id);
         _box.y = 126;
         LayerManager.topLayer.addChild(_box);
         MovieClipUtil.playMc(_box,1,_box.totalFrames,function():void
         {
            var _loc1_:int = 19 + id;
            InteractiveRewardManager.requestReward(_loc1_,onGetReward);
            if(_box)
            {
               DisplayObjectUtil.removeFromParent(_box);
               _box = null;
            }
         });
      }
      
      private static function onGetReward(param1:Parser_1060) : void
      {
         param1.showResult(true,_onCloseBox);
         if(_box)
         {
            DisplayObjectUtil.removeFromParent(_box);
            _box = null;
         }
      }
   }
}
