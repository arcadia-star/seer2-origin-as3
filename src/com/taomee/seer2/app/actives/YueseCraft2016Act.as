package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class YueseCraft2016Act
   {
      
      private static var _instance:YueseCraft2016Act;
       
      
      private const ARMY_ID:uint = 206356;
      
      private const ICON_NAME:Array = ["XIcon","YIcon","ZIcon"];
      
      public const ARMY_MAP_IDS:Array = [1300,81,3832];
      
      private var icon:IconDisplayer;
      
      public var army:uint;
      
      private const ACCEPT_DIALOGS:Array = [[[195,"雷文",[[0,"欢迎，英勇的赛尔。这里是天空竞技场，指挥最强大的精灵追逐荣耀的地方"]],["上尉，$nick$，前来报到！~"]],[195,"雷文",[[0,"等候你多时了，星际使者。欢迎来到X队的主场——天空竞技场，我是X队领队雷文，天空竞技场的管辖者。在进行宣誓仪式之前，我想先质询你几个问题。"]],[" 请说！"]],[195,"雷文",[[0,"在这耀眼的天空竞技场，强者得到认可，并取得其应得的荣耀。在这里，当你战胜了对手，你应该怎么做？"]],["   不居功自傲，不看低对手。"]],[195,"雷文",[[0,"（点头）正确的回答。实力是荣耀之源，但荣耀之源不仅是实力。在追逐荣耀的过程中，高傲自满、嘲笑弱者的人，无论实力多么强劲，都将失去他的荣耀。"]],[" 能力越强，责任越大"]],[195,"雷文",[[0,"在这耀眼的天空竞技场，强者得到认可，并取得其应得的荣耀。在这里，当你战胜了对手，你应该怎么做？"]],["   不居功自傲，不看低对手。"]],[195,"雷文",[[0,"（点头）正确的回答。实力是荣耀之源，但荣耀之源不仅是实力。在追逐荣耀的过程中，高傲自满、嘲笑弱者的人，无论实力多么强劲，都将失去他的荣耀。"]],["能力越强，责任越大"]],[195,"雷文",[[0,"恕我冒昧，请问雷文上尉——这届争霸赛的队伍定名似乎很特殊，采用了X、Y、Z三个简明却深奥的字母……"]],["   是有什么喻意吗？"]],[195,"雷文",[[0,"很好的问题。你认为X、Y、Z代表着什么呢？"]],["   ……未知的……未来？"]],[195,"雷文",[[0,"X、Y、Z三个字母，寓意着“未来”。赛尔号Ⅱ飞船能否再度起航？阿卡迪亚星的战火能否被扑灭？无尽能源能否被寻得？未来，谁都无法获知。但唯有一点，我们都明白。"]],["希望的微光，自始至终都在。对么？"]],[195,"雷文",[[0,"追逐希望，即追逐荣耀。这是天空竞技场的格律，更是X队每个赛尔战士的信条。彼岸摇曳着的希望之光，就在不远的未来等待着我们"]],["向着巅峰，不断迈进！"]],[195,"雷文",[[0,"不错，闪闪发光的眼神。欢迎加入X队——这X字背甲将伴随你在希望之光杯精灵王争霸赛上征战沙场。现在，去追寻你所信仰的荣耀与希望吧！！"]],[" 是的，上尉！  "]]],[[3,"门罗",[[0,"格瓦要塞……时代留存与铭记之地，战士瞻仰与蜕变之所。"]],["上尉，$nick$，前来报到！~"]],[3,"门罗",[[0,"欢迎，星际使者。这里是英格瓦要塞——Y队的主场。我是要塞军备长门罗，Y队领队。战士从不多言，客套话就免了。宣誓入队前，试问你数个问题。"]],["  请说！  "]],[3,"门罗",[[0,"英格瓦要塞，是每个新兵离开教官室后历练自己的必经之路。回忆、经验、传统……你选择怎么去支配自己曾经习得的一切？"]],["铭记历史，尊重时代。"]],[3,"门罗",[[0,"很好。英格瓦要塞，被称作战士的朝圣所。这里不仅仅训练新兵，更给重回旧地的朝圣者带来极端的挑战。当你抛下荣誉、抛下助力，用最朴素的骨架走在这钢铁浮岛之上……"]],["信仰所在，心中自明。"]],[3,"门罗",[[0,"恕我冒昧，请问门罗上尉——这届争霸赛的队伍定名似乎很特殊，采用了X、Y、Z三个简明却深奥的字母……"]],["是有什么喻意吗？~"]],[3,"门罗",[[0,"说说你自己的想法。"]],[" ……未知的……未来？"]],[3,"门罗",[[0,"X、Y、Z三个字母，寓意着“未来”。阿卡迪亚星的战火能否被扑灭？无尽能源能否被寻得？赛尔号Ⅱ飞船能否再度起航？未来未知，但希望永存。"]],["  希望的微光，自始至终都在。对么？"]],[3,"门罗",[[0,"铭记历史，即铭记希望。精钢铸就的英格瓦，乃是为了镌刻历史与希望而存在的、不朽的殿堂。彼岸摇曳着的希望之光，就在不远的未来等待着我们。:10-19:15去找下一个NPC娜维拉吧。"]],["向着巅峰，不断迈进！"]],[3,"门罗",[[0,"坚毅质朴的眼神。这件Y字背甲将伴随你在希望之光杯精灵王争霸赛上征战沙场——历史如火，斗志如焰。铭记历史，方能铭记希望！"]],["明白，上尉！"]]],[[400,"小赛尔",[[0,"Z队的主场居然是这神秘的太空武斗场啊……咦，那不是克拉克教官么"]],["教官？！你怎么在这里？！~"]],[6,"克拉克",[[0,"啊！我想起来了！螺丝钉的尺寸……啊不对！今天不是五周年庆典吗？我怎么把这个也忘了？"]],[" 菲鲁先生，我不正是来向你表示庆祝的吗？"]],[6,"克拉克",[[0,"哦！你是$nick$啊！欢迎欢迎！五年来，我一直遵守着严格的工艺流程和设计品质，年轻人你也要爱岗敬业啊！"]],["  谨记机械师的教导！"]],[6,"克拉克",[[0,"这些曜石能在VIP乐园打造装备，就送给你作为五周年贺礼了。19:10-19:15去找下一个NPC娜维拉吧。"]],["谢谢机械师"]]]];
      
      public function YueseCraft2016Act()
      {
         super();
      }
      
      public static function get instance() : YueseCraft2016Act
      {
         if(!_instance)
         {
            _instance = new YueseCraft2016Act();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         ChuanShuoZhuiSuAct.instance.setUp();
         ActiveCountManager.requestActiveCount(this.ARMY_ID,this.getArmy);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if(evt.content.params != "YueseCraft2016Act")
         {
            return;
         }
         ActiveCountManager.requestActiveCount(206357,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var value:uint = param2;
            if(value == 2)
            {
               if(SceneManager.active.mapID == ARMY_MAP_IDS[army - 1])
               {
                  NpcDialog.showDialogs(ACCEPT_DIALOGS[army - 1],function():void
                  {
                     SwapManager.swapItem(4533,1,function success(param1:IDataInput):void
                     {
                        new SwapInfo(param1);
                        setup();
                        ModuleManager.showAppModule("YueseCraft2016RulePanel");
                     },function failed(param1:uint):void
                     {
                     },new SpecialInfo(1,3));
                  });
               }
            }
         });
      }
      
      private function getArmy(param1:uint, param2:uint) : void
      {
         this.army = param2;
         if(this.army == 0)
         {
            return;
         }
         this.icon = new IconDisplayer();
         this.icon.setIconUrl(URLUtil.getActivityAnimation(this.ICON_NAME[this.army - 1]),this.onComplete);
      }
      
      private function onComplete() : void
      {
         ActorManager.getActor().addHeadIcon(this.icon);
      }
      
      public function initStep1() : void
      {
         if(SceneManager.active.mapID == 80518)
         {
            this.startStep1();
         }
         else
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function onComplete(param1:SceneEvent):void
            {
               if(SceneManager.active.type != SceneType.ARENA)
               {
                  SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
                  if(SceneManager.active.mapID == 80518)
                  {
                     startStep1();
                  }
               }
            });
            SceneManager.changeScene(SceneType.COPY,80518);
         }
      }
      
      private function startStep1() : void
      {
         var dialogs:Array = [[1,"辛迪",[[0,"你来了，$nick$。赛尔号Ⅱ光荣的战士，硕果满载的星际使者。"]],["不敢当，辛迪船长。"]],[1,"辛迪",[[0,"没有什么不敢当的。这是你在赛尔号Ⅱ飞船及阿卡迪亚星上所创造的功绩，理当得到赞许与敬重。"]],["荣幸之至。"]],[1,"辛迪",[[0,"时间过的真快啊。转眼间，赛尔号Ⅱ启航已有5个地球年之久了。每到这个缅怀历史、展望未来的时候，总有一项镌刻着荣耀的传统项目将同时在这SEERⅡ飞船上打响。我想，你应该……很清楚那是什么！"]],["精灵王争霸赛——我来了！"]],[1,"辛迪",[[0,"嗯。看你信心满满、意志坚定的样子，想必是有备而来。按照争霸赛的公正传统，你将随机入选三大阵容中的一队。不过在那之前，你需要先了解本届争霸赛的规则。"]],["  我这就去！"]]];
         NpcDialog.showDialogs(dialogs,function():void
         {
            SwapManager.swapItem(4533,1,function success(param1:IDataInput):void
            {
               new SwapInfo(param1);
               ModuleManager.showAppModule("YueseCraft2016MainPanel");
            },function failed(param1:uint):void
            {
            },new SpecialInfo(1,1));
         });
      }
      
      public function initStep2() : void
      {
         var dialogs:Array = [[1,"辛迪",[[0,"嗯。看你信心满满、意志坚定的样子，想必是有备而来。按照争霸赛的公正传统，你将随机入选三大阵容中的一队."]],["  我这就去！"]]];
         NpcDialog.showDialogs(dialogs,function():void
         {
            SwapManager.swapItem(4533,1,function success(param1:IDataInput):void
            {
               var data:IDataInput = param1;
               ActiveCountManager.requestActiveCount(ARMY_ID,function(param1:uint, param2:uint):void
               {
                  var type:uint = param1;
                  var value:uint = param2;
                  MovieClipUtil.playFullScreen("res/active/fullScreen/Team" + value + ".swf",function():void
                  {
                     ModuleManager.showAppModule("YueseCraft2016MainPanel");
                  });
               });
            },function failed(param1:uint):void
            {
            },new SpecialInfo(1,2));
         });
      }
      
      public function get teamRank() : int
      {
         if(this.army == 0)
         {
            return -1;
         }
         var _loc1_:Array = [0,2,1];
         return _loc1_[this.army - 1];
      }
   }
}
