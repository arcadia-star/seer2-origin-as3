package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.component.PetDemoDisplayer;
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class StarShadowManager
   {
      
      public static const indexArray:Array = [0,1,2,0,3,0,4,5];
      
      private static const DIALOG_CONFIG:Array = [[[[400,"小赛尔",[[0,"母船探测到的奇异的引力波讯号就是来自于这里了……好像没什么异样……咦，这是什么？"]],["（拾起星屑）"]]],[[400,"小赛尔",[[0,"母船探测到的奇异的引力波讯号就是来自于这里了……哇！那里好像有只精灵——天呐，那不是观星者吗？"]],["好像又有点儿长得不一样……"]],[3113,"星之首影",[[0,"吾……为……塞纳……留斯……圣徒。不敬者……速速……退避。"]],[" 什么鬼。。哇！！不要一言不合就开打啊！"]]],[[400,"小赛尔",[[0,"塞纳留斯圣徒！且留步！！"]],["传说中驾驭星空的精灵为何会出现在这里？"]],[3113,"星之首影",[[0,"吾等……驾驭星空王……执掌大地王……非今次之显者也。"]],["什么意思……听不懂……"]],[400,"小赛尔",[[0,"汝……可终此乱世。汝……将造就王者。"]],["诶？哇！又攻击我了！！"]]]],[[[400,"小赛尔",[[0,"又是一种波形不同的引力波讯号……不过强度和上一次星之首影出没时一模一样……咦，又有闪光的东西出现了。"]],["（拾起星屑）"]]],[[400,"小赛尔",[[0,"果然又是观星者的分身出现了……这次是纳法里奥圣徒吗？"]],["好像又有点儿长得不一样……"]],[3115,"星之躯影",[[0,"……拥有钢铁之躯……却远比……生灵脆弱的存在……汝等……本不应跨越光年至此……"]],[" 什么鬼。。哇！！不要一言不合就开打啊！"]]],[[400,"小赛尔",[[0,"纳法里奥圣徒！且留步！！"]],["传说中驾驭星空的精灵为何会出现在这里？"]],[3115,"星之躯影",[[0,"吾等……见证了那数万年的岁月。护佑、征伐。无数个伟大的存在，跨越天与地的隔阂，创造，毁灭，世间万物。那是上古的史诗……是神话的再临……"]],["无数个……伟大的存在？"]],[3115,"星之躯影",[[0,"王与神话并肩……神话沉眠，唯王遗世。王之躯散落，如世界骨架尽毁……王支撑其存在，神话守望着王……"]],[" 神话……指的是什么……卧槽，别打我啊！"]]]],[[[400,"小赛尔",[[0,"又是一种波形不同的引力波讯号，这次的波形似乎呈现出相当明显的正弦规律……啊，星屑发现！看来目标精灵已经离开这里了。"]],["（拾起星屑）"]]],[[400,"小赛尔",[[0,"那是……奎尔塞拉——！（深呼吸）和它打招呼获取那些似懂非懂的神谕吧！"]],["你好，奎尔塞拉！"]],[3116,"星之臂影",[[0,"……途苦旅中……用幻想填补的虚无……"]],[" 必将被真实之手……重新书写……"]]],[[400,"小赛尔",[[0,"奎尔塞拉圣徒！且留步！！"]],["传说中驾驭星空的精灵为何会出现在这里？"]],[3116,"星之臂影",[[0,"神创双灵，灵者有虚实之别。实者，阴阳二对，中有混沌。存阴阳为臂，如银河之漩，环混沌而成盛世。"]],["……虽然你说的也很难懂，但比之前的清晰多了！！"]],[3116,"星之臂影",[[0,"阴阳有别，于纪元末鏖战，其躯湮作灰烬，而大地断其双臂、折其筋骨。阴阳溃散至今，混沌终不可测……"]],["混沌……指的是什么……卧槽，别打我啊！"]]]],[],[[[400,"小赛尔",[[0,"星屑！并没有发现目标精灵。真是遗憾……话说回来，这次的讯号和第一次的讯号波形完全对称呢。"]],["（拾起星屑）"]]],[[400,"小赛尔",[[0,"从波形上看就觉得眼熟但又有所不同……果然是足影。"]],["你好，诺克萨斯！"]],[3120,"星之足影",[[0,"行于足下，光年尚不足惧。星空是汝等的路途……止步不前的理由，但求一个休憩之地而已。"]],[" ……休憩之地……？"]]],[[400,"小赛尔",[[0,"诺克萨斯圣徒！且留步！"]],["传说中驾驭星空的精灵为何会出现在这里？"]],[3120,"星之足影",[[0,"停滞的历史，停滞的方舟。汝等说……因意外而止步，为责任而驻足。区区一群硅基的存在……有为汝等的表态负责的觉悟吗？"]],["你的话好难懂……不过，觉悟是有的！"]],[3120,"星之足影",[[0,"……（沉默）,荒谬！！"]],["哇？？怎么突然就生气了？！"]]]],[],[[[400,"小赛尔",[[0,"星屑！并没有发现目标精灵。真是遗憾……话说回来，这次的讯号和第二次的讯号波形完全对称……真是微妙啊"]],["（拾起星屑）"]]],[[400,"小赛尔",[[0,"奥比休斯……星之背影吗！"]],["你好，奥比休斯！"]],[3121,"星之背影",[[0,"…………………………（沉默）"]],[" 那个。不说话吗……哇！！"]]],[[400,"小赛尔",[[0,"这次你跑不了了！！"]],["传说中驾驭星空的精灵为何会出现在这里？"]],[3121,"星之背影",[[0,"汝等。吾等。此间生灵。万物皆为其实，而生灵所见为虚。命，所谓实者作虚，虚者作实之轮回。"]],["有些难以理解……"]],[3121,"星之背影",[[0,"时空的长河，将真相冲洗殆尽。越过五千年，方能见证阴阳混沌并存之世。越过数万光年，方能认清虚实交替之轮回……"]],["诶？！诶为什么突然要打我？！"]]]],[[[400,"小赛尔",[[0,"星屑！并没有发现目标精灵。真是遗憾……话说回来，这次的讯号和第二次的讯号波形完全对称……真是微妙啊"]],["（拾起星屑）"]]],[[400,"小赛尔",[[0,"奥比休斯……星之心影吗！"]],["你好，奥比休斯！"]],[3123,"星之心影",[[0,"…………………………（沉默）"]],[" 那个。不说话吗……哇！！"]]],[[400,"小赛尔",[[0,"这次你跑不了了！！"]],["传说中驾驭星空的精灵为何会出现在这里？"]],[3123,"星之心影",[[0,"汝等。吾等。此间生灵。万物皆为其实，而生灵所见为虚。命，所谓实者作虚，虚者作实之轮回。"]],["有些难以理解……"]],[3123,"星之心影",[[0,"时空的长河，将真相冲洗殆尽。越过五千年，方能见证阴阳混沌并存之世。越过数万光年，方能认清虚实交替之轮回……"]],["诶？！诶为什么突然要打我？！"]]]],[]];
      
      public static const TYPE_ITEM:int = 0;
      
      public static const TYPE_PET:int = 1;
      
      private static var _mapId:int;
      
      private static var _iconId:int;
      
      private static var _getId:int;
      
      private static var _type:int;
      
      private static var _point:Point;
      
      private static var _icon:DisplayObject;
      
      private static var _activityIndex:int;
      
      private static var _canCatch:Boolean;
       
      
      public function StarShadowManager()
      {
         super();
      }
      
      public static function goMap(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Point, param7:Boolean = false) : void
      {
         _mapId = param1;
         _activityIndex = param2;
         _iconId = param4;
         _getId = param5;
         _type = param3;
         _point = param6;
         _canCatch = param7;
         if(SceneManager.active.mapID == param1)
         {
            initMap();
            return;
         }
         SceneManager.changeScene(SceneType.COPY,param1);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitch);
      }
      
      private static function onMapSwitch(param1:SceneEvent) : void
      {
         if(SceneManager.active.type != SceneType.ARENA)
         {
            if(_mapId == SceneManager.active.mapID)
            {
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitch);
               initMap();
            }
         }
      }
      
      private static function initMap() : void
      {
         var _loc1_:PetDemoDisplayer = null;
         var _loc2_:IconDisplayer = null;
         var _loc3_:String = null;
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,destoryMap);
         if(_type == TYPE_PET)
         {
            _loc1_ = new PetDemoDisplayer();
            _loc1_.newSetUrl(URLUtil.getPetDemo(PetConfig.getPetDefinition(_iconId).resId));
            _icon = _loc1_;
            _icon.scaleX = _icon.scaleY = 1.2;
         }
         if(_type == TYPE_ITEM)
         {
            _loc2_ = new IconDisplayer();
            _loc3_ = String(URLUtil.getRes("activity/icon/starShadow/" + _activityIndex + ".swf"));
            _loc2_.setIconUrl(_loc3_);
            _icon = _loc2_;
            _loc2_.setBoundary(120,120);
         }
         _icon["buttonMode"] = true;
         _icon.x = _point.x;
         _icon.y = _point.y;
         _icon.addEventListener(MouseEvent.CLICK,onIconClick);
         SceneManager.active.mapModel.front.addChild(_icon);
      }
      
      private static function onIconClick(param1:MouseEvent) : void
      {
         var dialogs:Array = null;
         var e:MouseEvent = param1;
         var canCatch:Boolean = false;
         if(_type == TYPE_ITEM)
         {
            dialogs = DIALOG_CONFIG[_activityIndex][0];
         }
         else
         {
            dialogs = DIALOG_CONFIG[_activityIndex][1];
            if(_canCatch)
            {
               dialogs = DIALOG_CONFIG[_activityIndex][2];
            }
         }
         NpcDialog.showDialogs(dialogs,function():void
         {
            var tempCurrent:int = 0;
            if(_type == TYPE_ITEM)
            {
               _icon.visible = false;
               tempCurrent = int(indexArray[_activityIndex]);
               SwapManager.swapItem(4580,1,function success(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  backMap();
               },null,new SpecialInfo(1,tempCurrent + 1));
            }
            else
            {
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onFightOver);
               FightManager.startFightWithWild(_getId);
            }
         });
      }
      
      private static function onFightOver(param1:* = null) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onFightOver);
            if(_getId == FightManager.currentFightRecord.initData.positionIndex)
            {
               backMap();
            }
         }
      }
      
      private static function backMap() : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
         ModuleManager.showAppModule("StarShadowPanel");
      }
      
      private static function destoryMap(param1:*) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,destoryMap);
         if(_icon != null)
         {
            _icon.removeEventListener(MouseEvent.CLICK,onIconClick);
            _icon = null;
         }
      }
   }
}
