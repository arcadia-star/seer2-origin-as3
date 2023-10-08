package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actives.YueseCraft2016Act;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   
   public class MapProcessor_3858 extends MapProcessor
   {
       
      
      private const DIALOGS:Array = [[[195,"雷文",[[0,"在追逐荣耀的过程中，高傲自满、嘲笑弱者的人，无论实力多么强劲，都将失去他的荣耀。这是天空竞技场的格律，更是X队每个赛尔战士的信条。"]],["雷文上尉威武！"]]],[[3,"门罗",[[0,"时代留存与铭记之地，战士瞻仰与蜕变之所……精钢铸就的英格瓦，乃是为了镌刻历史与希望而存在的、不朽的殿堂。Y之战火将燃遍沙场！"]],["铭记历史，即铭记希望。"]]],[[6,"克拉克",[[0,"Z队的主场，太空武斗场，象征着了赛尔战士培养的新曙光。竞技公平，资源公平——本即公平公正。Z队年轻的战士们，加油吧！"]],["英雄出少年啊！~"]]]];
      
      public function MapProcessor_3858(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         _map.content.addEventListener(MouseEvent.CLICK,this.onMapClick);
         _map.content["yinLin"].visible = false;
      }
      
      private function onMapClick(param1:MouseEvent) : void
      {
         var obj:* = undefined;
         var index:int = 0;
         var e:MouseEvent = param1;
         var btnName:String = String(e.target.name);
         switch(btnName)
         {
            case "scoreGate":
               obj = {};
               obj["tab"] = 1;
               ModuleManager.showAppModule("YueseCraft2016MainPanel",obj);
               break;
            case "ruleGate":
               ModuleManager.showAppModule("YueseCraft2016RulePanel");
               break;
            case "cindy":
               this.onCinDyClick();
         }
         if(btnName.indexOf("npc_") != -1)
         {
            index = parseInt(btnName.split("_")[1]);
            NpcDialog.showDialogs(this.DIALOGS[index],function():void
            {
            });
         }
      }
      
      private function onCinDyClick() : void
      {
         var arr:Array = [[1,"辛迪",[[0,"X、Y、Z三个字母，寓意着“未来”。阿卡迪亚星的战火能否被扑灭？无尽能源能否被寻得？赛尔号Ⅱ飞船能否再度起航？未来未知，但希望永存。"]],[" 希望之光杯精灵王争霸赛闭幕式"]]];
         NpcDialog.showDialogs(arr,function():void
         {
            if(YueseCraft2016Act.instance.teamRank == -1)
            {
               return;
            }
            receiveReward();
         });
      }
      
      private function receiveReward() : void
      {
         var dialogs0:Array = null;
         var dialogs1:Array = null;
         var receivePetDialogs:Array = null;
         var teamName:String = String(["X","Y","Z"][YueseCraft2016Act.instance.army - 1]);
         var rankName:String = String(["冠军","亚军","季军"][YueseCraft2016Act.instance.teamRank]);
         var npcName:String = String(["雷伊","凯萨","撒旦"][YueseCraft2016Act.instance.army - 1]);
         var medalColorName:String = String(["金","红","紫"][YueseCraft2016Act.instance.army - 1]);
         var medalStr:String = String(["光辉四溢","令人热血沸腾","深邃而高贵"][YueseCraft2016Act.instance.army - 1]);
         dialogs0 = [[1,"辛迪",[[0,"你来了，$nick$。赛尔号Ⅱ光荣的战士，硕果满载的星际使者。"]],["不敢当，辛迪船长。"]],[1,"辛迪",[[0,"你所在的队伍——" + teamName + "队，在希望之光杯精灵王争霸赛中获得了" + rankName + "。接下来将向你颁发冠军队奖励，请收下属于你的荣耀！"]],["雷文上尉威武！"]]];
         dialogs1 = [[1,"辛迪",[[0,medalColorName + "色的" + teamName + "字勋章……真是" + medalStr + "的色彩……！没能带领队伍夺魁，稍显遗憾；但你的表现足以令人折服"]],["承蒙船长认可！"]],[1,"辛迪",[[0,"最后，容我转告" + npcName + "托我向你转达的讯息。遗憾并不可怕，可怕的是放弃努力。你在大赛中已经打出了气势、创造了荣耀，你的“旗帜”为你而骄傲。"]],["我也为他骄傲！"]],[1,"辛迪",[[0,"回到探索的步伐中去吧。这颗星球上，还有更多的挑战和故事需要你去见证。去吧，勇敢的战士！"]],[" 是，船长！"]]];
         receivePetDialogs = [[1,"辛迪",[[0,medalColorName + "色的" + teamName + "字勋章……真是" + medalStr + "正如" + npcName + "所言，你果然带领" + teamName + "队夺得了冠军——星际使者真是名副其实。"]],["承蒙船长认可！"]],[511,"影灵的幻视",[[0,"真是神采奕奕。吾也忍不住想要夸赞汝的努力了"]],["……？！影灵的幻视？！！"]]];
         ActiveCountManager.requestActiveCountList([206375],function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            var flag:int = int(par.infoVec[0]);
            if(BitUtil.getBit(flag,0) == 0)
            {
               NpcDialog.showDialogs(dialogs0,function():void
               {
                  if(YueseCraft2016Act.instance.teamRank == 0)
                  {
                     receivePet(receivePetDialogs);
                  }
                  else
                  {
                     NpcDialog.showDialogs(dialogs1,function():void
                     {
                     });
                  }
                  SwapManager.swapItem(4571,1,function success(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                  },function failed(param1:uint):void
                  {
                  },new SpecialInfo(1,1));
               });
            }
            else if(BitUtil.getBit(flag,1) == 0 && YueseCraft2016Act.instance.teamRank == 0)
            {
               receivePet(receivePetDialogs);
            }
         });
      }
      
      private function receivePet(param1:Array) : void
      {
         var dialogs:Array = param1;
         NpcDialog.showDialogs(dialogs,function():void
         {
            var mv:MovieClip = _map.content["yinLin"];
            mv.visible = true;
            MovieClipUtil.playMc(mv,2,mv.totalFrames - 1,function():void
            {
               var arr:Array = [[511,"影灵的幻视",[[0,"吾已观察这场盛大的赛事已久。星际使者——汝的品质令吾十分满意。作为认可，吾有兴趣在接下来的旅程中伴你一同前行。希望在接下来的日子里，吾能见证你所寻得的真实。"]],[" 感谢你的认可，影灵兽"]]];
               NpcDialog.showDialogs(arr,function():void
               {
                  SwapManager.swapItem(4571,1,function success(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                  },function failed(param1:uint):void
                  {
                  },new SpecialInfo(1,2));
               });
            },true);
         });
      }
      
      override public function dispose() : void
      {
         _map.content.removeEventListener(MouseEvent.CLICK,this.onMapClick);
         super.dispose();
      }
   }
}
