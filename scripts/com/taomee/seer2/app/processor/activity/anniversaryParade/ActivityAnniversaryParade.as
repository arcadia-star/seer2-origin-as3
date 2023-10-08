package com.taomee.seer2.app.processor.activity.anniversaryParade
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.questAnswer.QuestInfo;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   
   public class ActivityAnniversaryParade
   {
      
      private static var _instance:com.taomee.seer2.app.processor.activity.anniversaryParade.ActivityAnniversaryParade;
       
      
      public const config:Array = [["克拉克教官",6,60],["菲鲁",4,50],["娜维拉",7,30],["伊娃博士",2,20],["乔休尔",5,40],["辛迪船长",1,10]];
      
      private var questions0:Array;
      
      private var questions1:Array;
      
      public function ActivityAnniversaryParade()
      {
         this.questions0 = [["今年是约瑟传说多少周岁生日？",["5周岁","3周岁","1周岁"],1],["令精灵王约瑟重生的关键是什么？",["17种王魄","\'希望之光\'","打败奎尔斯"],2],["在萨伦帝国与北半球联盟长久的战争与对峙中，暗影氏族的立场是什么？",["与萨伦帝国合作","支持北半球联盟","中立"],3]];
         this.questions1 = [["以下哪个地图存在绿色矿脉",["异蘑世界","异蘑谷","悲伤残骸"],3],["在地图【深幽沼泽】中可以收集到以下哪种道具？",["黄铁矿","\'夜明珠\'","藤蔓花子"],1],["《赛尔计划》建造深空探索机器人及远航星舰的根本目标是？",["捕获、进化更多精灵，构筑正义的精灵战队、打击宇宙邪恶势力","寻找传说中的“无尽能源”挽救资源枯竭的地球","寻找地球文明能够移居的新星球"],2]];
         super();
      }
      
      public static function get instance() : com.taomee.seer2.app.processor.activity.anniversaryParade.ActivityAnniversaryParade
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.processor.activity.anniversaryParade.ActivityAnniversaryParade();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var mapId:int;
         var npcIndex:int = 0;
         var i:int = 0;
         var evt:DialogPanelEvent = param1;
         if(evt.content.params != "activityAnniversaryParade")
         {
            return;
         }
         npcIndex = 0;
         mapId = int(SceneManager.active.mapID);
         i = 0;
         while(i < this.config.length)
         {
            if(this.config[i][2] == mapId)
            {
               npcIndex = i;
               break;
            }
            i++;
         }
         DayLimitListManager.getDaylimitList([1932],function callback(param1:DayLimitListInfo):void
         {
            var _loc3_:Array = null;
            var _loc2_:int = int(param1.getCount(1932));
            if(BitUtil.getBit(_loc2_,i) != 0)
            {
               AlertManager.showAlert("今天已经拜访过" + config[npcIndex][0]);
            }
            else
            {
               _loc3_ = [processNpc0,processNpc1,processNpc2,processNpc3,processNpc4,processNpc5];
               if(isInTime(npcIndex))
               {
                  _loc3_[npcIndex]();
               }
               else
               {
                  AlertManager.showAlert("不在拜访" + config[npcIndex][0] + "的时间内！");
               }
            }
         });
      }
      
      private function processNpc0() : void
      {
         var dialogs:Array = [[6,"克拉克",[[0,"咦？这不是……$nick$嘛！带着这么一大批赛尔一同前来，是想要挑战我吗？（微笑）"]],["别来无恙，教官！五周年快乐！~"]],[6,"克拉克",[[0,"喔喔，原来是五周年的游行庆典啊……看这时间，第一站便是我这教官室？真是倍感荣幸！想当年，你还是个毛头小子……一转眼，星际使者在这赛尔号Ⅱ飞船上的名声已经比我还大了！"]],["不敢当！还得感谢教官当年的栽培！"]],[6,"克拉克",[[0,"五年的岁月，将你打磨成了一个坚韧的战士……但这还远远不够。智慧，品格，作为赛尔机器人应有的素养……时机正好，让我来考验下你成长了多少吧！"]],["与教官切磋","我再准备下"]]];
         NpcDialog.showDialogs(dialogs,function():void
         {
            var fightId:int = 0;
            fightId = 1812;
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function complete(param1:SceneEvent):void
            {
               var e:SceneEvent = param1;
               if(SceneManager.prevSceneType == SceneType.ARENA)
               {
                  SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,complete);
                  if(fightId == FightManager.currentFightRecord.initData.positionIndex && FightManager.isWinWar())
                  {
                     NpcDialog.show(6,"克拉克",[[0,"真是惊人的蜕变……果然没有看错你！（赞许的眼神）这些礼品是我精心准备的五周年贺礼，尽管拿去吧！（别忘了19:05-19:10去找下一个NPC菲鲁哦）"]],["谢谢教官！"],[function():void
                     {
                        finishStep(0,function():void
                        {
                        });
                     }]);
                  }
               }
            });
            FightManager.startFightWithWild(fightId);
         });
      }
      
      private function processNpc1() : void
      {
         var dialogs:Array = [[4,"菲鲁",[[0,"那个……那个谁？你看见我的螺丝刀了吗？诶？不对？我好像有什么更重要的事情要处理来着？"]],["机械师菲鲁还是忙得不可开交呢……~"]],[4,"菲鲁",[[0,"啊！我想起来了！螺丝钉的尺寸……啊不对！今天不是五周年庆典吗？我怎么把这个也忘了？"]],[" 菲鲁先生，我不正是来向你表示庆祝的吗？"]],[4,"菲鲁",[[0,"哦！你是$nick$啊！欢迎欢迎！五年来，我一直遵守着严格的工艺流程和设计品质，年轻人你也要爱岗敬业啊！"]],["  谨记机械师的教导！"]],[4,"菲鲁",[[0,"这些曜石能在VIP乐园打造装备，就送给你作为五周年贺礼了。19:10-19:15去找下一个NPC娜维拉吧。"]],["谢谢机械师"]]];
         NpcDialog.showDialogs(dialogs,function():void
         {
            finishStep(1,function():void
            {
            });
         });
      }
      
      private function processNpc2() : void
      {
         var dialog1:Array = null;
         var dialogs:Array = [[7,"娜威拉",[[0,"这里是资料室，赛尔号Ⅱ的智慧中枢。巨型量子计算机中存储并实时分析着赛尔号Ⅱ起航5年来所获取的一切信息，记载着……这颗阿卡迪亚星上，我们已知的所有历史、以及无数未知的谜团。"]],[" 5年前，我们还对这颗美丽的星球一无所知呢。~"]],[7,"娜威拉",[[0,"哟，$nick$。想要复习一下阿卡迪亚星的历史和未来吗？(⊙ω⊙)"]],[" 非常乐意！~"]]];
         dialog1 = [[7,"娜威拉",[[0,"时光过的真是快。五年前我们跃迁至这片星域、迫降在阿卡迪亚星的冰原上……五年后，我们已经与这颗阿卡迪亚星融为了一体。"]],[" 对这颗神秘的星球的探索还远远不够呢。~"]],[7,"娜威拉",[[0,"是啊……哈哈哈。对于SEERⅡ飞船上的我们而言……这颗阿卡迪亚星，不知不觉地，似乎已经成为了我们的第二故乡了。文明、精灵、自然……这里的一切都令我们倍感珍惜。就好像……（酸涩）(⊙ω⊙)"]],[" ……像极了曾经那么美丽的……地球啊"]],[7,"娜威拉",[[0,"启航五年之际，伤感的话还是不多说了。无论如何，谢谢你对约瑟传说的不离不弃——在接下来的日子里，约瑟传说会一如既往的努力，带你度过无数个更精彩的日日夜夜。(⊙ω⊙)"]],[" 约瑟传说，永不言败！！！"]],[7,"娜威拉",[[0,"好了，说了这么多，该送上我的五周年贺礼了。请收下这些星钻碎片~,以及，别忘了在19:15-19:20期间，去实验室寻找伊娃博士哦！"]],[" 谢谢情报官！"]]];
         NpcDialog.showDialogs(dialogs,function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("59_2"),function():void
            {
               NpcDialog.showDialogs(dialog1,function():void
               {
                  finishStep(2,function():void
                  {
                  });
               });
            });
         });
      }
      
      private function processNpc3() : void
      {
         var dialogs1:Array = null;
         var dialogs:Array = [[1001,"伊娃",[[0,"精灵……遍及宇宙的神奇的生命。自然赋予了它们伟大的力量……我们应当去敬畏、去构建互助，而不是单方面的利用、甚至伤害它们……"]],[" 伊娃博士！五周年快乐！~"]],[1001,"伊娃",[[0,"哇！$nick$！今天怎么想起来到实验室看望我了？~（高兴）"]],["约瑟传说五岁了，我们在举办游行活动"]],[1001,"伊娃",[[0,"嘿嘿嘿，你是想要我的五周年贺礼吧？既然来了实验室——那就该让我来考考你了哟！（严肃）认真思考，回答我的问题！答对3题的话，我就会给你奖励！~（高兴）"]],[" 我准备好了！（认真）"]]];
         dialogs1 = [[1001,"伊娃",[[0,"时光过的真是快。五年前我们跃迁至这片星域、迫降在阿卡迪亚星的冰原上……五年后，我们已经与这颗阿卡迪亚星融为了一体。"]],[" 对这颗神秘的星球的探索还远远不够呢。~"]],[1001,"伊娃",[[0,"是啊……哈哈哈。对于SEERⅡ飞船上的我们而言……这颗阿卡迪亚星，不知不觉地，似乎已经成为了我们的第二故乡了。文明、精灵、自然……这里的一切都令我们倍感珍惜。就好像……（酸涩）(⊙ω⊙)"]],[" ……像极了曾经那么美丽的……地球啊"]],[1001,"伊娃",[[0,"启航五年之际，伤感的话还是不多说了。无论如何，谢谢你对约瑟传说的不离不弃——在接下来的日子里，约瑟传说会一如既往的努力，带你度过无数个更精彩的日日夜夜。(⊙ω⊙)"]],[" 约瑟传说，永不言败！！！"]],[1001,"伊娃",[[0,"好了，说了这么多，该送上我的五周年贺礼了。请收下这些星钻碎片~,以及，别忘了在19:15-19:20期间，去实验室寻找伊娃博士哦！"]],[" 谢谢情报官！"]]];
         NpcDialog.showDialogs(dialogs,function():void
         {
            startQuest(questions0,function():void
            {
               NpcDialog.showDialogs(dialogs1,function():void
               {
                  finishStep(3,function():void
                  {
                  });
               });
            });
         });
      }
      
      private function processNpc4() : void
      {
         var dialogs1:Array = null;
         var dialogs:Array = [[5,"乔休尔",[[0,"五年了啊……这艘庞然大物究竟是为何飞不起来呢？……动力室是整个飞船的能源中心，虽然飞船已经搁浅了很长时间，但是我仍旧要守住这个十分重要的岗位……"]],[" 伊娃博士！五周年快乐！~"]],[5,"乔休尔",[[0,"哇！$nick$！今天怎么想起来到实验室看望我了？~（高兴）"]],["约瑟传说五岁了，我们在举办游行活动"]],[5,"乔休尔",[[0,"不过，既然来到这动力室，想要拿走奖励，就得用你的智慧来换咯！~（高兴）"]],["  又要答题？放马过来！"]]];
         dialogs1 = [[5,"乔休尔",[[0,"不错，很正确的知识库存。是个有潜能的孩子。看样子，游行活动也快结束了吧？19:25-19:30去船长室找辛迪船长吧，船长似乎有神秘的奖励要发放给你。"]],[" 对这颗神秘的星球的探索还远远不够呢。~"]]];
         NpcDialog.showDialogs(dialogs,function():void
         {
            startQuest(questions1,function():void
            {
               NpcDialog.showDialogs(dialogs1,function():void
               {
                  finishStep(4,function():void
                  {
                  });
               });
            });
         });
      }
      
      private function processNpc5() : void
      {
         var dialogs:Array = [[1,"辛迪",[[0,"五年来，我们曾经叩问希望、寻找希望——其实，希望之光就在我们的心中。在微光的指引下，我们不离不弃，携手并肩，毅然前行。"]],[" 时光过的真快啊。~"]],[1,"辛迪",[[0,"又是一年盛夏。看着你的蜕变和成就，作为船长，我为你骄傲。追逐着信仰、勇气和力量的年轻人啊……向着未来，傲首前行吧！"]],[" 赛尔号Ⅱ，飞跃巅峰！！"]]];
         NpcDialog.showDialogs(dialogs,function():void
         {
            finishStep(5,function():void
            {
            });
         });
      }
      
      private function finishStep(param1:int, param2:Function) : void
      {
         var step:int = param1;
         var callback:Function = param2;
         SwapManager.swapItem(4534,1,function success(param1:IDataInput):void
         {
            new SwapInfo(param1);
            ModuleManager.showAppModule("AnniversaryParadePanel");
         },function failed(param1:uint):void
         {
         },new SpecialInfo(1,step + 1));
      }
      
      private function startQuest(param1:Array, param2:Function) : void
      {
         var index:int = 0;
         var fun:Function = null;
         var questions:Array = param1;
         var callback:Function = param2;
         index = 0;
         ;
         ;
         fun = function():void
         {
            var answers:Vector.<String>;
            var i:int;
            var qs:Vector.<QuestInfo>;
            var question:QuestInfo = new QuestInfo();
            question.ask = questions[index][0];
            answers = new Vector.<String>();
            i = 0;
            while(i < questions[index][1].length)
            {
               answers.push(questions[index][1][i]);
               i++;
            }
            question.selectItems = answers;
            question.answer = questions[index][2];
            qs = new Vector.<QuestInfo>();
            qs.push(question);
            ModuleManager.showModule(URLUtil.getAppModule("QuestAnswerPanel"),"正在打开答题面板...",{
               "time":60,
               "questions":qs,
               "isRandom":false,
               "timeOutFunc":function(param1:int):void
               {
                  if(param1 == 0)
                  {
                     return;
                  }
                  ++index;
                  if(index == questions.length)
                  {
                     callback();
                  }
                  else
                  {
                     TweenNano.delayedCall(0.5,fun);
                  }
               }
            });
         };
         fun();
      }
      
      private function isInTime(param1:int) : Boolean
      {
         var _loc2_:Array = [15,22,29];
         var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc3_.fullYear == 2016 && _loc3_.month == 6 && _loc2_.indexOf(_loc3_.date) != -1 && _loc3_.hours == 19)
         {
            if(_loc3_.minutes >= param1 * 5 && _loc3_.minutes < (param1 + 1) * 5)
            {
               return true;
            }
         }
         return false;
      }
   }
}
