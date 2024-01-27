package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.init.LoginInfo;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.net.URLRequest;
import flash.net.URLRequestMethod;

public class StatisticsManager {

    public static const NEWS:String = "newsBroadcast";

    public static const ENTER_DREAM:String = "enterDream";

    public static const QUEST_3_CATCHPET:String = "quest3CatchPet";

    public static const QUEST_3_HUNTMONSTER:String = "quest3HuntMonster";

    public static const onlineFailed:String = "online_conn_failed";

    public static const onlineSandbox:String = "online_safe_sandbox";

    public static const startGotoCaptenMap:String = "0x1003467F";

    public static const gotoCaptenMap:String = "0x1003468E";

    public static const talkToCapten:String = "0x10030594";

    public static const clickMapBtn_1:String = "0x10030595";

    public static const clickShipBtn_1:String = "0x10030596";

    public static const gotoInstructorsMap:String = "0x10034680";

    public static const clickPetMC:String = "0x10030598";

    public static const selectPet:String = "0x10030599";

    public static const startFight:String = "0x1003059A";

    public static const fightLoadSuccess:String = "0x1003059B";

    public static const fightSuccess:String = "0x1003059C";

    public static const talkToInstructors:String = "0x1003059D";

    public static const talkToBadi:String = "0x1003059E";

    public static const clickMapBtn_2:String = "0x1003059F";

    public static const clickShipBtn_2:String = "0x10030600";

    public static const taskOver:String = "0x10030601";

    public static const ui_interact_2:String = "0x10030603";

    public static const ui_interact_1:String = "0x10030602";

    public static const ui_interact_8:String = "0x10030609";

    public static const ui_interact_7:String = "0x10030608";

    public static const ui_interact_6:String = "0x10030607";

    public static const ui_interact_5:String = "0x10030606";

    public static const ui_interact_4:String = "0x10030605";

    public static const ui_interact_3:String = "0x10030604";

    public static const ui_interact_9:String = "0x1003060A";

    public static const ui_interact_10:String = "0x1003060B";

    public static const ui_interact_11:String = "0x1003060C";

    public static const ui_interact_12:String = "0x1003060D";

    public static const ui_interact_13:String = "0x1003060E";

    public static const ui_interact_14:String = "0x1003060F";

    public static const ui_interact_15:String = "0x10030610";

    public static const ui_interact_16:String = "0x10030611";

    public static const ui_interact_17:String = "0x10030612";

    public static const ui_interact_18:String = "0x10030613";

    public static const ui_interact_19:String = "0x10030614";

    public static const ui_interact_20:String = "0x10030615";

    public static const ui_interact_21:String = "0x10033001";

    public static const ui_interact_22:String = "0x10033002";

    public static const ui_interact_23:String = "0x10033003";

    public static const ui_interact_24:String = "0x10033004";

    public static const ui_home_newspaper:String = "0x10033048";

    public static const ui_interact_25:String = "0x1003303f";

    public static const ui_interact_26:String = "0x10033044";

    public static const ui_interact_27:String = "0x10033033";

    public static const ui_interact_28:String = "0x10033034";

    public static const ui_interact_29:String = "0x10033035";

    public static const ui_interact_30:String = "0x10033036";

    public static const ui_interact_31:String = "0x10033037";

    public static const ui_interact_32:String = "0x10033038";

    public static const ui_interact_33:String = "0x10033039";

    public static const ui_interact_34:String = "0x1003303a";

    public static const ui_interact_35:String = "0x10033047";

    public static const ui_interact_36:String = "0x10033046";

    public static const ui_interact_37:String = "0x10033062";

    public static const ui_interact_38:String = "0x10033063";

    public static const ui_interact_39:String = "0x10033067";

    public static const ui_interact_40:String = "0x10033065";

    public static const ui_interact_41:String = "0x1003306e";

    public static const ui_interact_42:String = "0x1003306f";

    public static const ui_interact_43:String = "0x10033069";

    public static const ui_interact_44:String = "0x1003306a";

    public static const ui_interact_45:String = "0x10033094";

    public static const ui_interact_46:String = "0x10033095";

    public static const ui_interact_47:String = "ui_9";

    public static const ui_interact_48:String = "ui_10";

    public static const ui_interact_49:String = "ui_11";

    public static const ui_interact_50:String = "ui_12";

    public static const ui_interact_51:String = "ui_13";

    public static const ui_interact_52:String = "ui_14";

    public static const ui_interact_53:String = "ui_15";

    public static const ui_interact_54:String = "ui_16";

    public static const ui_interact_55:String = "ui_17";

    public static const ui_interact_56:String = "0x1003311B";

    public static const ui_interact_57:String = "0x10033127";

    public static const ui_interact_58:String = "0x10033128";

    public static const ui_interact_59:String = "0x10033129";

    public static const ui_interact_60:String = "0x1003312A";

    public static const ui_interact_61:String = "0x1003312B";

    public static const ui_interact_62:String = "0x1003312C";

    public static const ui_interact_63:String = "0x1003312E";

    public static const ui_interact_64:String = "0x10033130";

    public static const map_entry_90:String = "0x10033111";

    public static const map_entry_160:String = "0x10033112";

    public static const map_entry_230:String = "0x10033113";

    public static const map_entry_470:String = "0x10033114";

    public static const map_entry_320:String = "0x10033115";

    public static const map_entry_770:String = "0x10033116";

    public static const map_entry_540:String = "0x10033117";

    public static const map_entry_81:String = "0x10033118";

    public static const map_entry_8011:String = "0x10033119";

    public static const map_entry_790:String = "0x1003311A";

    public static const vip_click:String = "0x10033152";

    public static const ui_interact_65:String = "0x10033155";

    public static const ui_interact_66:String = "0x10033156";

    public static const ui_interact_67:String = "0x10033157";

    public static const ui_interact_68:String = "0x10033158";

    public static const ui_interact_69:String = "0x10033159";

    public static const ui_interact_70:String = "0x10033176";

    public static const ui_interact_71:String = "0x10033177";

    public static const ui_interact_72:String = "0x1003318D";

    public static const ui_interact_73:String = "0x1003320E";

    public static const ui_interact_74:String = "0x1003320F";

    public static const ui_interact_75:String = "0x10033210";

    public static const ui_interact_76:String = "0x1003323A";

    public static const ui_interact_77:String = "0x1003323B";

    public static const ui_interact_78:String = "0x1003323C";

    public static const ui_interact_79:String = "0x1003323D";

    public static const ui_interact_80:String = "0x1003323E";

    public static const ui_interact_81:String = "0x10033258";

    public static const ui_interact_82:String = "0x10033259";

    public static const ui_interact_83:String = "0x1003326A";

    public static const ui_interact_84:String = "0x1003326B";

    public static const ui_interact_85:String = "0x1003326c";

    public static const ui_interact_86:String = "0x1003326d";

    public static const ui_interact_87:String = "0x1003326e";

    public static const ui_interact_88:String = "0x1003326f";

    public static const ui_interact_89:String = "0x10033260";

    public static const ui_interact_90:String = "0x1003329C";

    public static const ui_interact_91:String = "0x10033294";

    public static const ui_interact_92:String = "0x1003330B";

    public static const ui_interact_93:String = "0x10033297";

    public static const ui_interact_94:String = "0x10033398";

    public static const ui_interact_96:String = "0x1003332e";

    public static const ui_interact_97:String = "0x10033318";

    public static const ui_interact_98:String = "0x10033319";

    public static const ui_interact_99:String = "0x1003332b";

    public static const ui_interact_100:String = "0x10033323";

    public static const ui_interact_101:String = "0x10033344";

    public static const ui_interact_102:String = "0x10033345";

    public static const ui_interact_103:String = "0x1003336C";

    public static const ui_interact_104:String = "0x1003336D";

    public static const ui_interact_105:String = "0x1003336E";

    public static const ui_interact_106:String = "0x1003336F";

    public static const ui_interact_107:String = "0x1003335E";

    public static const ui_interact_108:String = "0x10033384";

    public static const ui_interact_109:String = "0x1003339D";

    public static const ui_interact_110:String = "0x1003340C";

    public static const ui_interact_111:String = "0x10033401";

    public static const ui_interact_112:String = "0x10033402";

    public static const ui_interact_113:String = "0x10033403";

    public static const ui_interact_114:String = "0x1003338C";

    public static const ui_interact_115:String = "0x1003338D";

    public static const ui_interact_116:String = "0x1003338E";

    public static const ui_interact_117:String = "0x1003338F";

    public static const ui_interact_118:String = "0x10033380";

    public static const ui_interact_119:String = "0x10033381";

    public static const ui_interact_120:String = "0x10033410";

    public static const ui_interact_121:String = "0x10033411";

    public static const ui_interact_122:String = "0x10033412";

    public static const ui_interact_123:String = "0x10033413";

    public static const ui_interact_124:String = "0x10033414";

    public static const ui_interact_125:String = "0x10033415";

    public static const ui_interact_126:String = "0x10033416";

    public static const ui_interact_127:String = "0x10033417";

    public static const ui_interact_128:String = "0x10033418";

    public static const ui_interact_129:String = "0x10033419";

    public static const ui_interact_130:String = "0x1003341A";

    public static const ui_interact_131:String = "0x1003341B";

    public static const ui_interact_132:String = "0x1003341C";

    public static const ui_interact_133:String = "0x1003341D";

    public static const ui_interact_134:String = "0x1003341E";

    public static const ui_interact_135:String = "0x1003341F";

    public static const ui_interact_136:String = "0x10033420";

    public static const ui_interact_137:String = "0x10033421";

    public static const ui_interact_138:String = "0x10033422";

    public static const ui_interact_139:String = "0x10033423";

    public static const ui_interact_140:String = "0x10033424";

    public static const ui_interact_141:String = "0x10033425";

    public static const ui_interact_142:String = "0x10033426";

    public static const ui_interact_143:String = "0x10033427";

    public static const ui_interact_144:String = "0x10033428";

    public static const ui_interact_145:String = "0x10033429";

    public static const ui_interact_146:String = "0x1003342A";

    public static const ui_interact_147:String = "0x1003342B";

    public static const ui_interact_148:String = "0x1003342C";

    public static const ui_interact_149:String = "0x1003342D";

    public static const ui_interact_150:String = "0x1003342E";

    public static const ui_interact_151:String = "0x1003342F";

    public static const ui_interact_152:String = "0x10033430";

    public static const ui_interact_153:String = "0x10033431";

    public static const ui_interact_154:String = "0x10033432";

    public static const ui_interact_155:String = "0x10033433";

    public static const ui_interact_156:String = "0x10033434";

    public static const ui_interact_157:String = "0x10033435";

    public static const ui_interact_158:String = "0x10033436";

    public static const ui_interact_159:String = "0x10033437";

    public static const ui_interact_160:String = "0x10033438";

    public static const ui_interact_161:String = "0x10033439";

    public static const ui_interact_162:String = "0x1003343A";

    public static const ui_interact_163:String = "0x1003343B";

    public static const ui_interact_164:String = "0x1003343C";

    public static const ui_interact_165:String = "0x1003343D";

    public static const ui_interact_166:String = "0x1003343E";

    public static const ui_interact_167:String = "0x1003343F";

    public static const ui_interact_168:String = "0x10033440";

    public static const ui_interact_169:String = "0x10033441";

    public static const ui_interact_170:String = "0x10033442";

    public static const ui_interact_171:String = "0x10033443";

    public static const ui_interact_172:String = "0x10033444";

    public static const ui_interact_173:String = "0x10033445";

    public static const ui_interact_174:String = "0x10033446";

    public static const ui_interact_175:String = "0x10033447";

    public static const ui_interact_176:String = "0x10033448";

    public static const ui_interact_177:String = "0x10033449";

    public static const ui_interact_178:String = "0x1003344A";

    public static const ui_interact_179:String = "0x1003344B";

    public static const ui_interact_180:String = "0x1003344C";

    public static const ui_interact_181:String = "0x1003344D";

    public static const ui_interact_182:String = "0x1003344E";

    public static const ui_interact_183:String = "0x1003344F";

    public static const ui_interact_206:String = "0x10033450";

    public static const ui_interact_184:String = "0x10033451";

    public static const ui_interact_185:String = "0x10033452";

    public static const ui_interact_186:String = "0x10033453";

    public static const ui_interact_187:String = "0x10033454";

    public static const ui_interact_188:String = "0x10033455";

    public static const ui_interact_189:String = "0x10033456";

    public static const ui_interact_190:String = "0x10033457";

    public static const ui_interact_191:String = "0x10033458";

    public static const ui_interact_192:String = "0x10033459";

    public static const ui_interact_193:String = "0x1003345A";

    public static const ui_interact_194:String = "0x1003345B";

    public static const ui_interact_195:String = "0x1003345C";

    public static const ui_interact_196:String = "0x1003345D";

    public static const ui_interact_197:String = "0x1003345E";

    public static const ui_interact_198:String = "0x1003345F";

    public static const ui_interact_199:String = "0x10033460";

    public static const ui_interact_200:String = "0x10033461";

    public static const ui_interact_201:String = "0x10033462";

    public static const ui_interact_202:String = "0x10033463";

    public static const ui_interact_203:String = "0x10033464";

    public static const ui_interact_204:String = "0x10033465";

    public static const ui_interact_205:String = "0x10033466";

    public static const ui_interact_208:String = "0x10033482";

    public static const ui_interact_209:String = "0x10033467";

    public static const ui_interact_210:String = "0x10033468";

    public static const ui_interact_211:String = "0x10033469";

    public static const ui_interact_212:String = "0x1003346A";

    public static const ui_interact_213:String = "0x1003346B";

    public static const ui_interact_214:String = "0x1003346C";

    public static const ui_interact_215:String = "0x1003346D";

    public static const ui_interact_216:String = "0x1003346E";

    public static const ui_interact_217:String = "0x1003346F";

    public static const ui_interact_218:String = "0x10033470";

    public static const ui_interact_219:String = "0x10033471";

    public static const ui_interact_220:String = "0x10033472";

    public static const ui_interact_221:String = "0x10033473";

    public static const ui_interact_222:String = "0x10033474";

    public static const ui_interact_223:String = "0x10033475";

    public static const ui_interact_224:String = "0x10033476";

    public static const ui_interact_225:String = "0x10033477";

    public static const ui_interact_226:String = "0x10033478";

    public static const ui_interact_227:String = "0x10033479";

    public static const ui_interact_228:String = "0x1003347A";

    public static const ui_interact_229:String = "0x1003347B";

    public static const ui_interact_230:String = "0x1003347C";

    public static const ui_interact_231:String = "0x1003347D";

    public static const ui_interact_232:String = "0x1003347E";

    public static const ui_interact_233:String = "0x1003347F";

    public static const ui_interact_234:String = "0x10033480";

    public static const ui_interact_235:String = "0x10033481";

    public static const ui_interact_236:String = "0x10033404";

    public static const ui_interact_237:String = "0x10033405";

    public static const ui_interact_238:String = "0x10033406";

    public static const ui_interact_239:String = "0x10033407";

    public static const ui_interact_240:String = "0x1003348E";

    public static const ui_interact_241:String = "0x1003348F";

    public static const ui_interact_242:String = "0x10033490";

    public static const ui_interact_243:String = "0x10033491";

    public static const ui_interact_244:String = "0x10033492";

    public static const ui_interact_245:String = "0x10033493";

    public static const ui_interact_246:String = "0x10033510";

    public static const ui_interact_247:String = "0x10033511";

    public static const ui_interact_248:String = "0x10033512";

    public static const ui_interact_249:String = "0x10033513";

    public static const ui_interact_250:String = "0x10033494";

    public static const ui_interact_251:String = "0x10033561";

    public static const ui_interact_252:String = "0x10033562";

    public static const ui_interact_253:String = "0x10033563";

    public static const ui_interact_254:String = "0x10033564";

    public static const ui_interact_255:String = "0x10033565";

    public static const ui_interact_256:String = "0x10033566";

    public static const ui_interact_257:String = "0x10033567";

    public static const ui_interact_258:String = "0x10033568";

    public static const ui_interact_259:String = "0x10033569";

    public static const ui_interact_260:String = "0x1003356A";

    public static const ui_interact_261:String = "0x1003356B";

    public static const ui_interact_262:String = "0x1003356C";

    public static const ui_interact_263:String = "0x1003356D";

    public static const ui_interact_264:String = "0x1003356E";

    public static const ui_interact_265:String = "0x1003356F";

    public static const ui_interact_266:String = "0x10033570";

    public static const ui_interact_267:String = "0x10033571";

    public static const ui_interact_268:String = "0x10033572";

    public static const ui_interact_269:String = "0x10033573";

    public static const ui_interact_270:String = "0x10033574";

    public static const ui_interact_271:String = "0x10033575";

    public static const ui_interact_272:String = "0x10033576";

    public static const ui_interact_273:String = "0x10033577";

    public static const ui_interact_274:String = "0x10033578";

    public static const ui_interact_275:String = "0x10033579";

    public static const ui_interact_276:String = "0x1003357A";

    public static const ui_interact_277:String = "0x1003357B";

    public static const ui_interact_278:String = "0x1003357C";

    public static const ui_interact_279:String = "0x1003357D";

    public static const ui_interact_280:String = "0x1003357E";

    public static const ui_interact_281:String = "0x1003357F";

    public static const ui_interact_282:String = "0x10033582";

    public static const ui_interact_283:String = "0x10033583";

    public static const ui_interact_284:String = "0x10033584";

    public static const ui_interact_285:String = "0x10033585";

    public static const ui_interact_286:String = "0x10033586";

    public static const ui_interact_287:String = "0x10033587";

    public static const ui_interact_288:String = "0x10033588";

    public static const ui_interact_289:String = "0x10033589";

    public static const ui_interact_290:String = "0x1003358A";

    public static const ui_interact_291:String = "0x10033599";

    public static const ui_interact_292:String = "0x1003359A";

    public static const ui_interact_293:String = "0x1003359B";

    public static const ui_interact_294:String = "0x1003359C";

    public static const ui_interact_295:String = "0x1003359D";

    public static const ui_interact_296:String = "0x1003359E";

    public static const ui_interact_297:String = "0x1003359F";

    public static const ui_interact_298:String = "0x10033600";

    public static const ui_interact_299:String = "0x10033601";

    public static const ui_interact_300:String = "0x10033602";

    public static const ui_interact_301:String = "0x10033598";

    public static const ui_interact_302:String = "0x10033606";

    public static const ui_interact_303:String = "0x10033607";

    public static const ui_interact_304:String = "0x10033608";

    public static const ui_interact_305:String = "0x10033609";

    public static const ui_interact_306:String = "0x1003360A";

    public static const ui_interact_307:String = "0x1003360B";

    public static const ui_interact_308:String = "0x1003360C";

    public static const ui_interact_309:String = "0x1003360D";

    public static const ui_interact_310:String = "0x1003360E";

    public static const ui_interact_311:String = "0x1003360F";

    public static const ui_interact_312:String = "0x10033610";

    public static const ui_interact_313:String = "0x10033611";

    public static const ui_interact_314:String = "0x10033612";

    public static const ui_interact_315:String = "0x10033613";

    public static const ui_interact_316:String = "0x10033614";

    public static const ui_interact_317:String = "0x10033615";

    public static const ui_interact_318:String = "0x10033616";

    public static const ui_interact_319:String = "0x10033617";

    public static const ui_interact_320:String = "0x10033618";

    public static const ui_interact_321:String = "0x10033619";

    public static const ui_interact_322:String = "0x1003361A";

    public static const ui_interact_323:String = "0x1003361B";

    public static const ui_interact_324:String = "0x1003361C";

    public static const ui_interact_325:String = "0x1003361D";

    public static const ui_interact_326:String = "0x1003361E";

    public static const ui_interact_327:String = "0x1003361F";

    public static const ui_interact_328:String = "0x10033620";

    public static const ui_interact_329:String = "0x10033621";

    public static const ui_interact_330:String = "0x10033622";

    public static const ui_interact_331:String = "0x10033623";

    public static const ui_interact_332:String = "0x10033624";

    public static const ui_interact_333:String = "0x10033625";

    public static const ui_interact_334:String = "0x10033626";

    public static const ui_interact_335:String = "0x10033627";

    public static const ui_interact_336:String = "0x10033628";

    public static const ui_interact_337:String = "0x10033629";

    public static const ui_interact_338:String = "0x1003362A";

    public static const ui_interact_339:String = "0x1003362B";

    public static const ui_interact_340:String = "0x1003362C";

    public static const ui_interact_341:String = "0x1003362D";

    public static const ui_interact_342:String = "0x1003362E";

    public static const ui_interact_343:String = "0x1003362F";

    public static const ui_interact_344:String = "0x10033630";

    public static const ui_interact_345:String = "0x10033631";

    public static const ui_interact_346:String = "0x10033632";

    public static const ui_interact_347:String = "0x10033633";

    public static const ui_interact_348:String = "0x10033634";

    public static const ui_interact_349:String = "0x1003363B";

    public static const ui_interact_350:String = "0x10033643";

    public static const ui_interact_351:String = "0x10033642";

    public static const ui_interact_352:String = "0x10033648";

    public static const ui_interact_353:String = "0x1003364B";

    public static const ui_interact_354:String = "0x1003364C";

    public static const ui_interact_355:String = "0x1003364D";

    public static const ui_interact_356:String = "0x1003364E";

    public static const ui_interact_357:String = "0x1003364F";

    public static const ui_interact_358:String = "0x10033650";

    public static const ui_interact_359:String = "0x10033651";

    public static const ui_interact_360:String = "0x1003362E";

    public static const ui_interact_361:String = "0x10033649";

    public static const ui_interact_362:String = "0x1003362F";

    public static const ui_interact_363:String = "0x1003366A";

    public static const ui_interact_364:String = "0x1003366B";

    public static const ui_interact_365:String = "0x1003366D";

    public static const ui_interact_366:String = "0x1003366E";

    public static const ui_interact_367:String = "0x1003366F";

    public static const ui_interact_368:String = "0x10033670";

    public static const ui_interact_369:String = "0x10033671";

    public static const ui_interact_370:String = "0x1003370D";

    public static const ui_interact_371:String = "0x10033695";

    public static const ui_interact_372:String = "0x10033696";

    public static const ui_interact_373:String = "0x10033697";

    public static const ui_interact_374:String = "0x10033698";

    public static const ui_interact_375:String = "0x10033699";

    public static const ui_interact_376:String = "0x1003370F";

    public static const ui_interact_377:String = "0x10033710";

    public static const ui_interact_378:String = "0x10033727";

    public static const ui_interact_379:String = "0x10033713";

    public static const ui_interact_380:String = "0x1003372A";

    public static const ui_interact_381:String = "0x10033732";

    public static const ui_interact_382:String = "0x1003372F";

    public static const ui_interact_383:String = "0x10033731";

    public static const ui_interact_384:String = "0x10033734";

    public static const ui_interact_385:String = "0x10033736";

    public static const ui_interact_386:String = "0x10033738";

    public static const ui_interact_387:String = "0x1003373A";

    public static const ui_interact_388:String = "0x1003373F";

    public static const ui_interact_389:String = "0x10033749";

    public static const ui_interact_390:String = "0x1003374A";

    public static const ui_interact_391:String = "0x1003373D";

    public static const ui_interact_392:String = "0x1003373E";

    public static const ui_interact_393:String = "0x10033745";

    public static const ui_interact_394:String = "0x1003374F";

    public static const ui_interact_395:String = "0x1003375D";

    public static const ui_interact_396:String = "0x1003375E";

    public static const ui_interact_397:String = "0x1003374B";

    public static const ui_interact_398:String = "0x1003374D";

    public static const ui_interact_399:String = "0x1003374E";

    public static const ui_interact_400:String = "0x10033761";

    public static const ui_interact_401:String = "0x10033762";

    public static const ui_interact_402:String = "0x10033763";

    public static const ui_interact_403:String = "0x10033764";

    public static const ui_interact_404:String = "0x10033775";

    public static const ui_interact_405:String = "0x10033776";

    public static const ui_interact_406:String = "0x10033777";

    public static const ui_interact_407:String = "0x10033778";

    public static const ui_interact_408:String = "0x10033779";

    public static const ui_interact_409:String = "0x1003377A";

    public static const ui_interact_410:String = "0x1003377B";

    public static const ui_interact_411:String = "0x10033766";

    public static const uui_interact_412:String = "0x10033768";

    public static const uui_interact_413:String = "0x10033781";

    public static const uui_interact_414:String = "0x10033783";

    public static const ui_interact_415:String = "0x1003377F";

    public static const ui_interact_416:String = "0x1003377C";

    public static const ui_interact_417:String = "0x1003377E";

    public static const ui_interact_418:String = "0x10033780";

    public static const ui_interact_419:String = "0x1003377D";

    public static const ui_interact_420:String = "0x10033786";

    public static const ui_interact_421:String = "0x10033787";

    public static const ui_interact_422:String = "0x10033788";

    public static const ui_interact_423:String = "0x10033789";

    public static const ui_interact_424:String = "0x10033797";

    public static const ui_interact_425:String = "0x1003379B";

    public static const ui_interact_426:String = "0x1003379D";

    public static const ui_interact_427:String = "0x1003379F";

    public static const ui_interact_428:String = "0x10033800";

    public static const ui_interact_429:String = "0x10033793";

    public static const ui_interact_430:String = "0x10033794";

    public static const ui_interact_431:String = "0x10033795";

    public static const ui_interact_432:String = "0x10033796";

    public static const ui_interact_433:String = "0x10033797";

    public static const ui_interact_434:String = "0x10033798";

    public static const ui_interact_435:String = "0x10033799";

    public static const ui_interact_436:String = "0x1003380B";

    public static const ui_interact_437:String = "0x1003380C";

    public static const ui_interact_438:String = "0x1003380F";

    public static const ui_interact_439:String = "0x1003381D";

    public static const ui_interact_440:String = "0x10033807";

    public static const ui_interact_441:String = "0x10033808";

    public static const ui_interact_442:String = "0x1003380A";

    public static const ui_interact_443:String = "0x10033818";

    public static const ui_interact_444:String = "0x10033809";

    public static const ui_interact_445:String = "0x10033812";

    public static const ui_interact_446:String = "0x10033813";

    public static const ui_interact_447:String = "0x10033819";

    public static const ui_interact_448:String = "0x1003381F";

    public static const ui_interact_449:String = "0x1003382E";

    public static const ui_interact_450:String = "0x1003381F";

    public static const ui_interact_451:String = "0x10033821";

    public static const ui_interact_452:String = "0x10033826";

    public static const ui_interact_453:String = "0x10033827";

    public static const ui_interact_454:String = "0x1003383E";

    public static const ui_interact_455:String = "0x10033840";

    public static const ui_interact_456:String = "0x1003384E";

    public static const ui_interact_457:String = "0x10033842";

    public static const ui_interact_458:String = "0x10033848";

    public static const ui_interact_459:String = "0x10033849";

    public static const ui_interact_460:String = "0x1003384A";

    public static const ui_interact_461:String = "0x1003384B";

    public static const ui_interact_462:String = "0x1003384C";

    public static const ui_interact_463:String = "0x1003384D";

    public static const ui_interact_464:String = "0x10033854";

    public static const ui_interact_465:String = "0x10033856";

    public static const ui_interact_466:String = "0x10033858";

    public static const ui_interact_467:String = "0x10033852";

    public static const ui_interact_468:String = "0x10033859";

    public static const ui_interact_469:String = "0x10033865";

    public static const ui_interact_470:String = "0x10033866";

    public static const ui_interact_471:String = "0x1003385E";

    public static const ui_interact_472:String = "0x1003385B";

    public static const ui_interact_473:String = "0x10033867";

    public static const ui_interact_474:String = "0x10033868";

    public static const ui_interact_475:String = "0x1003385F";

    public static const ui_interact_476:String = "0x10033874";

    public static const ui_interact_477:String = "0x10033876";

    public static const ui_interact_478:String = "0x10033870";

    public static const ui_interact_479:String = "0x10033890";

    public static const ui_interact_480:String = "0x1003387A";

    public static const ui_interact_481:String = "0x1003387E";

    public static const ui_interact_482:String = "0x1003387F";

    public static const ui_interact_483:String = "0x10033880";

    public static const ui_interact_484:String = "0x10033881";

    public static const ui_interact_485:String = "0x10033883";

    public static const ui_interact_486:String = "0x1003388E";

    public static const ui_interact_487:String = "0x1003388F";

    public static const ui_interact_488:String = "0x10033893";

    public static const ui_interact_489:String = "0x10033895";

    public static const ui_interact_490:String = "0x10033897";

    public static const ui_interact_491:String = "0x10033898";

    public static const ui_interact_492:String = "0x10033899";

    public static const ui_interact_494:String = "0x1003390A";

    public static const ui_interact_495:String = "0x1003390B";

    public static const ui_interact_496:String = "0x1003390C";

    public static const ui_interact_497:String = "0x1003390D";

    public static const ui_interact_493:String = "0x1003390E";

    public static const ui_interact_498:String = "0x10034682";

    public static const ui_interact_499:String = "0x10034681";

    public static const ui_interact_500:String = "0x10033911";

    public static const ui_interact_501:String = "0x10033912";

    public static const ui_interact_502:String = "0x10033913";

    public static const ui_interact_503:String = "0x10033914";

    public static const ui_interact_504:String = "0x10033915";

    public static const ui_interact_505:String = "0x10033916";

    public static const ui_interact_506:String = "0x10033917";

    public static const ui_interact_507:String = "0x1003392A";

    public static const ui_interact_508:String = "0x1003392C";

    public static const ui_interact_509:String = "0x1003392E";

    public static const ui_interact_510:String = "0x10033921";

    public static const ui_interact_511:String = "0x1003393E";

    public static const ui_interact_512:String = "0x10033935";

    public static const ui_interact_513:String = "0x1003394A";

    public static const ui_interact_514:String = "0x1003394B";

    public static const ui_interact_515:String = "0x10033931";

    public static const ui_interact_516:String = "0x10033933";

    public static const ui_interact_517:String = "0x1003395B";

    public static const ui_interact_518:String = "0x10033962";

    public static const ui_interact_519:String = "0x10033964";

    public static const ui_interact_520:String = "0x10033965";

    public static const ui_interact_521:String = "0x10033968";

    public static const ui_interact_522:String = "0x10033969";

    public static const ui_interact_523:String = "0x10033950";

    public static const ui_interact_524:String = "0x10033952";

    public static const ui_interact_525:String = "0x10033953";

    public static const ui_interact_526:String = "0x10033986";

    public static const ui_interact_527:String = "0x10033974";

    public static const ui_interact_528:String = "0x10033975";

    public static const ui_interact_529:String = "0x1003397A";

    public static const ui_interact_530:String = "0x10033989";

    public static const ui_interact_531:String = "0x1003398A";

    public static const ui_interact_532:String = "0x1003398B";

    public static const ui_interact_533:String = "0x10034002";

    public static const ui_interact_534:String = "0x10034003";

    public static const ui_interact_535:String = "0x10034004";

    public static const ui_interact_536:String = "0x10033997";

    public static const ui_interact_537:String = "0x1003399C";

    public static const ui_interact_538:String = "0x1003401C";

    public static const ui_interact_539:String = "0x10034023";

    public static const ui_interact_540:String = "0x10034017";

    public static const ui_interact_541:String = "0x10034018";

    public static const ui_interact_542:String = "0x10034032";

    public static const ui_interact_543:String = "0x10034043";

    public static const ui_interact_544:String = "0x1003404D";

    public static const ui_interact_545:String = "0x1003404E";

    public static const ui_interact_546:String = "0x1003402B";

    public static const ui_interact_547:String = "0x10034064";

    public static const ui_interact_548:String = "0x10034050";

    public static const ui_interact_549:String = "0x10034051";

    public static const ui_interact_550:String = "0x1003406C";

    public static const ui_interact_551:String = "0x10034087";

    public static const ui_interact_552:String = "0x10034088";

    public static const ui_interact_553:String = "0x10034105";

    public static const ui_interact_554:String = "0x10034106";

    public static const ui_interact_555:String = "0x1003410f";


    public function StatisticsManager() {
        super();
    }

    public static function setup():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
    }

    private static function onStepComplete(param1:QuestEvent):void {
        if (param1.questId == 3) {
            if (QuestManager.isStepComplete(3, 3) && QuestManager.isStepComplete(3, 4) == false) {
                StatisticsManager.sendStatisticsByType(StatisticsManager.QUEST_3_CATCHPET);
            } else if (QuestManager.isStepComplete(3, 5) && QuestManager.isStepComplete(3, 6) == false) {
                StatisticsManager.sendStatisticsByType(StatisticsManager.QUEST_3_HUNTMONSTER);
            }
        }
    }

    public static function sendStatisticsByUrl(param1:String):void {
        var _loc2_:URLRequest = null;
        if (Boolean(param1) && param1 != "") {
            _loc2_ = new URLRequest(param1);
            _loc2_.method = URLRequestMethod.GET;
            sendToURL(_loc2_);
        }
    }

    public static function sendStatisticsByType(param1:String):void {
        var _loc3_:URLRequest = null;
        var _loc2_:String = generateURL(param1);
        if (_loc2_) {
            _loc3_ = new URLRequest(_loc2_);
            _loc3_.method = URLRequestMethod.GET;
            sendToURL(_loc3_);
        }
    }

    private static function generateURL(param1:String):String {
        switch (param1) {
            case NEWS:
                return "http://misc.taomee.com/seer2/seer2.php?type=news_broadcast&mm=" + ActorManager.actorInfo.id;
            case ENTER_DREAM:
                return "http://misc.taomee.com/seer2/seer2.php?type=little_kui_dream&mm=" + ActorManager.actorInfo.id;
            case QUEST_3_CATCHPET:
                return "http://misc.taomee.com/seer2/seer2.php?type=catch_fala&mm=" + ActorManager.actorInfo.id;
            case QUEST_3_HUNTMONSTER:
                return "http://misc.taomee.com/seer2/seer2.php?type=fight_fala&mm=" + ActorManager.actorInfo.id;
            default:
                return null;
        }
    }

    public static function sendError(param1:String):void {
        sendToURL(new URLRequest("http://misc.taomee.com/monitor/technical_report.php?game=" + ClientConfig.productID + "&type=" + param1));
    }

    public static function sendNovice(param1:String):void {
        sendToURL(new URLRequest("http://newmisc.taomee.com/misc.txt?type=" + param1 + "&mm=" + LoginInfo.account + "&count=1"));
    }

    public static function sendNoviceAccountHttpd(param1:String):void {
        sendToURL(new URLRequest("http://misc.taomee.com/seer2/seer2.php?type=" + param1 + "&mm=" + LoginInfo.account));
    }

    public static function newSendNovice(param1:String, param2:String, param3:String):void {
        StatisticsManager2.sendHttpStat(param1, param2, param3, LoginInfo.account);
    }

    private static function sendToURL(urlRequest:URLRequest):void {
        trace("StatisticsManager error ", urlRequest);
    }
}
}
