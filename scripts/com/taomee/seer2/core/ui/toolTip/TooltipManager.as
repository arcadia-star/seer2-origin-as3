package com.taomee.seer2.core.ui.toolTip
{
   import com.taomee.seer2.core.ui.toolTip.tipSkins.CommonTipSkin;
   import com.taomee.seer2.core.ui.toolTip.tipSkins.ExternalTipSkin;
   import com.taomee.seer2.core.ui.toolTip.tipSkins.GameTipSkin;
   import com.taomee.seer2.core.ui.toolTip.tipSkins.IconTipSkin;
   import com.taomee.seer2.core.ui.toolTip.tipSkins.ItemTipSkin;
   import com.taomee.seer2.core.ui.toolTip.tipSkins.MultipletipSkin;
   import com.taomee.seer2.core.ui.toolTip.tipSkins.SkillTipSkin;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   
   public class TooltipManager
   {
      
      private static var _toolTip:BaseTooltip;
       
      
      public function TooltipManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         _toolTip = new BaseTooltip();
      }
      
      public static function addExternalTip(param1:InteractiveObject, param2:MovieClip, param3:String = "", param4:Function = null, param5:Function = null, param6:* = null) : void
      {
         _toolTip.add(param1,param3,new ExternalTipSkin(param2),param4,param5,param6);
      }
      
      public static function addCommonTip(param1:InteractiveObject, param2:String, param3:Function = null, param4:Function = null, param5:* = null) : void
      {
         _toolTip.add(param1,param2,new CommonTipSkin(),param3,param4,param5);
      }
      
      public static function addIconTip(param1:InteractiveObject, param2:uint, param3:Boolean, param4:String) : void
      {
         _toolTip.add(param1,param4,new IconTipSkin(param2,param3),null,null,null);
      }
      
      public static function addGameTip(param1:InteractiveObject, param2:String) : void
      {
         _toolTip.add(param1,param2,new GameTipSkin());
      }
      
      public static function addMultipleTip(param1:InteractiveObject, param2:String) : void
      {
         _toolTip.add(param1,param2,new MultipletipSkin());
      }
      
      public static function addItemTip(param1:InteractiveObject, param2:Object = null) : void
      {
         _toolTip.add(param1,"",new ItemTipSkin());
         _toolTip.setData(param1,param2);
      }
      
      public static function addSkillTip(param1:InteractiveObject, param2:Object = null) : void
      {
         _toolTip.add(param1,"",new SkillTipSkin());
         _toolTip.setData(param1,param2);
      }
      
      public static function changeTip(param1:InteractiveObject, param2:String) : void
      {
         _toolTip.chanegTip(param1,param2);
      }
      
      public static function setData(param1:InteractiveObject, param2:Object) : void
      {
         _toolTip.setData(param1,param2);
      }
      
      public static function remove(param1:InteractiveObject) : void
      {
         _toolTip.remove(param1);
      }
      
      public static function addArtTips(param1:InteractiveObject, param2:DisplayObject) : void
      {
         if(param2 is MovieClip)
         {
            MovieClip(param2).mouseEnabled = MovieClip(param2).mouseChildren = false;
         }
         DisplayObjectUtil.removeFromParent(param2);
         _toolTip.addArtTips(param1,param2);
      }
      
      public static function addPetQualityTips(param1:int, param2:InteractiveObject, param3:Boolean = false) : void
      {
         var _loc4_:* = "";
         if(param1 <= 11)
         {
            _loc4_ = "当前潜力值：" + param1 + "\n" + "下一级还需:" + (12 - param1);
         }
         if(param1 >= 12 && param1 <= 21)
         {
            _loc4_ = "当前潜力值:" + param1 + "\n" + "下一级还需:" + (22 - param1);
         }
         if(param1 >= 22)
         {
            if(param3)
            {
               if(param1 >= 22 && param1 <= 23)
               {
                  _loc4_ = "当前潜力值:" + param1 + "\n" + "下一级还需:" + (24 - param1);
               }
               if(param1 >= 24 && param1 <= 27)
               {
                  _loc4_ = "当前潜力值:" + param1 + "\n" + "下一级还需:" + (28 - param1);
               }
               if(param1 >= 28 && param1 <= 30)
               {
                  _loc4_ = "当前潜力值:" + param1 + "\n" + "下一级还需:" + (31 - param1);
               }
               if(param1 >= 31)
               {
                  _loc4_ = "当前潜力值:" + param1 + "\n" + "已达最大潜力值";
               }
            }
            else
            {
               _loc4_ = "资质未鉴定";
            }
         }
         addCommonTip(param2,_loc4_);
      }
   }
}
