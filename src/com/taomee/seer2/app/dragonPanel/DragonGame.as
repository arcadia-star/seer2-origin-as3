package com.taomee.seer2.app.dragonPanel
{
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.LayerManager;
   import org.taomee.utils.DisplayUtil;
   
   public class DragonGame
   {
      
      public static var fightWithFishID:int;
      
      private static var _fishGameMain:DragonGameStart;
      
      private static var _libs:ResourceLibrary;
      
      private static var _count:uint;
       
      
      public function DragonGame()
      {
         super();
      }
      
      public static function createGame() : void
      {
         if(_fishGameMain)
         {
            DisplayUtil.removeForParent(_fishGameMain);
            _fishGameMain = null;
         }
         LayerManager.hideMap();
         _fishGameMain = new DragonGameStart(_libs,_count);
         LayerManager.topLayer.addChild(_fishGameMain);
      }
      
      public static function set libs(param1:ResourceLibrary) : void
      {
         _libs = param1;
      }
      
      public static function get libs() : ResourceLibrary
      {
         return _libs;
      }
      
      public static function set count(param1:uint) : void
      {
         _count = param1;
      }
      
      public static function get count() : uint
      {
         return _count;
      }
   }
}
