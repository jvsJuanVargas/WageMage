class_name OptionsHandler


# Get resolution data ----------------------------------------------------------
static func get_resolution_data(resolution:Resolution) -> Dictionary:
	var resolution_vector : Vector2i = Vector2i(960, 540)
	var aspect_ratio : AspectRatio = AspectRatio.ASPECT_RATIO_16_9
	match (resolution):
		Resolution.RESOLUTION_640_400:
			resolution_vector = Vector2i(640, 400)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_10
		Resolution.RESOLUTION_640_480:
			resolution_vector = Vector2i(640, 480)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_720_480:
			resolution_vector = Vector2i(720, 480)
			aspect_ratio = AspectRatio.ASPECT_RATIO_3_2
		Resolution.RESOLUTION_800_600:
			resolution_vector = Vector2i(800, 600)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_960_540:
			resolution_vector = Vector2i(960,540)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_960_720:
			resolution_vector = Vector2i(960, 720)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_1024_576:
			resolution_vector = Vector2i(1024, 576)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_1024_768:
			resolution_vector = Vector2i(1024, 768)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_1140_900:
			resolution_vector = Vector2i(1140, 900)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_10
		Resolution.RESOLUTION_1152_648:
			resolution_vector = Vector2i(1152, 648)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_1152_768:
			resolution_vector = Vector2i(1152, 768)
			aspect_ratio = AspectRatio.ASPECT_RATIO_3_2
		Resolution.RESOLUTION_1280_720:
			resolution_vector = Vector2i(1280, 720)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_1280_768:
			resolution_vector = Vector2i(1280, 768)
			aspect_ratio = AspectRatio.ASPECT_RATIO_5_3
		Resolution.RESOLUTION_1280_800:
			resolution_vector = Vector2i(1280, 800)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_10
		Resolution.RESOLUTION_1280_854:
			resolution_vector = Vector2i(1280, 854)
			aspect_ratio = AspectRatio.ASPECT_RATIO_3_2
		Resolution.RESOLUTION_1280_960:
			resolution_vector = Vector2i(1280, 960)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_1280_1024:
			resolution_vector = Vector2i(1280, 1024)
			aspect_ratio = AspectRatio.ASPECT_RATIO_5_4
		Resolution.RESOLUTION_1366_768:
			resolution_vector = Vector2i(1366, 768)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_1400_1050:
			resolution_vector = Vector2i(1400, 1050)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_1440_960:
			resolution_vector = Vector2i(1440, 960)
			aspect_ratio = AspectRatio.ASPECT_RATIO_3_2
		Resolution.RESOLUTION_1440_1080:
			resolution_vector = Vector2i(1440, 1080)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_1600_900:
			resolution_vector = Vector2i(1600, 900)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_1600_1200:
			resolution_vector = Vector2i(1600, 1200)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_1856_1392:
			resolution_vector = Vector2i(1856, 1392)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_1920_1080:
			resolution_vector = Vector2i(1920, 1080)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_1920_1200:
			resolution_vector = Vector2i(1920, 1200)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_10
		Resolution.RESOLUTION_1920_1440:
			resolution_vector = Vector2i(1920, 1440)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_2048_1152:
			resolution_vector = Vector2i(2048, 1152)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_2048_1536:
			resolution_vector = Vector2i(2048, 1536)
			aspect_ratio = AspectRatio.ASPECT_RATIO_4_3
		Resolution.RESOLUTION_2560_1080:
			resolution_vector = Vector2i(2560, 1080)
			aspect_ratio = AspectRatio.ASPECT_RATIO_21_9
		Resolution.RESOLUTION_2560_1440:
			resolution_vector = Vector2i(2560, 1440)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_2560_1600:
			resolution_vector = Vector2i(2560, 1600)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_10
		Resolution.RESOLUTION_2560_2048:
			resolution_vector = Vector2i(2560, 2048)
			aspect_ratio = AspectRatio.ASPECT_RATIO_5_4
		Resolution.RESOLUTION_2880_1920:
			resolution_vector = Vector2i(2880, 1920)
			aspect_ratio = AspectRatio.ASPECT_RATIO_3_2
		Resolution.RESOLUTION_3000_1800:
			resolution_vector = Vector2i(3000, 1800)
			aspect_ratio = AspectRatio.ASPECT_RATIO_5_3
		Resolution.RESOLUTION_3440_1440:
			resolution_vector = Vector2i(3440, 1440)
			aspect_ratio = AspectRatio.ASPECT_RATIO_21_9
		Resolution.RESOLUTION_3840_1080:
			resolution_vector = Vector2i(3840, 1080)
			aspect_ratio = AspectRatio.ASPECT_RATIO_32_9
		Resolution.RESOLUTION_3840_2160:
			resolution_vector = Vector2i(3840, 2160)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
		Resolution.RESOLUTION_3840_2400:
			resolution_vector = Vector2i(3840, 2400)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_10
		Resolution.RESOLUTION_5120_1440:
			resolution_vector = Vector2i(5120, 1440)
			aspect_ratio = AspectRatio.ASPECT_RATIO_32_9
		Resolution.RESOLUTION_5120_2160:
			resolution_vector = Vector2i(5120, 2160)
			aspect_ratio = AspectRatio.ASPECT_RATIO_21_9
		Resolution.RESOLUTION_5120_4096:
			resolution_vector = Vector2i(5120, 4096)
			aspect_ratio = AspectRatio.ASPECT_RATIO_5_4
		_:
			resolution_vector = Vector2i(960, 540)
			aspect_ratio = AspectRatio.ASPECT_RATIO_16_9
	return {
		'resolution': resolution_vector,
		'aspect_ratio': aspect_ratio,
	}


# Get OS locale ----------------------------------------------------------------
static func get_os_locale() -> Locale:
	var os_locale : Locale
	var locale_code : String = OS.get_locale()
	if ['en_US', 'en_GB',].find(locale_code):
		os_locale = Locale.EN_US
	elif ['pt_BR',].find(locale_code):
		os_locale = Locale.PT_BR
	elif ['pt_PT',].find(locale_code):
		os_locale = Locale.PT_PT
	elif ['es_ES', 'es_MX'].find(locale_code):
		os_locale = Locale.ES_ES
	elif ['es_AR',].find(locale_code):
		os_locale = Locale.ES_LA
	elif ['it_IT', 'it_CH',].find(locale_code):
		os_locale = Locale.IT_IT
	elif ['fr_FR',].find(locale_code):
		os_locale = Locale.FR_FR
	elif ['de_DE', 'de_CH', 'de_AT',].find(locale_code):
		os_locale = Locale.DE_DE
	elif ['ru_RU',].find(locale_code):
		os_locale = Locale.RU_RU
	elif ['ja_JP',].find(locale_code):
		os_locale = Locale.JA_JP
	elif ['zh_CN', 'zh_SG',].find(locale_code):
		os_locale = Locale.ZH_CN
	elif ['zh_TW', 'zh_HK', 'zh_MO',].find(locale_code):
		os_locale = Locale.ZH_TW
	elif ['ko_KR',].find(locale_code):
		os_locale = Locale.KO_KR
	else:
		os_locale = Locale.EN_US
	return os_locale


# Get locale code --------------------------------------------------------------
static func get_locale_code(locale:Locale) -> String:
	var locale_code : String
	match locale:
		Locale.DE_DE:
			locale_code = 'de_DE'
		Locale.EN_US:
			locale_code = 'en_US'
		Locale.ES_ES:
			locale_code = 'es_ES'
		Locale.ES_LA:
			locale_code = 'es_LA'
		Locale.FR_FR:
			locale_code = 'fr_FR'
		Locale.IT_IT:
			locale_code = 'it_IT'
		Locale.JA_JP:
			locale_code = 'ja_JP'
		Locale.KO_KR:
			locale_code = 'ko_KR'
		Locale.PT_BR:
			locale_code = 'pt_BR'
		Locale.PT_PT:
			locale_code = 'pt_PT'
		Locale.RU_RU:
			locale_code = 'ru_RU'
		Locale.ZH_CN:
			locale_code = 'zh_CN'
		Locale.ZH_TW:
			locale_code = 'zh_TW'
		_:
			locale_code = 'en_US'
	return locale_code


# Game enums ===================================================================

# Aspect ratios ----------------------------------------------------------------
enum AspectRatio {
	ASPECT_RATIO_3_2,	ASPECT_RATIO_4_3,	ASPECT_RATIO_5_3,	ASPECT_RATIO_5_4,
	ASPECT_RATIO_16_9,	ASPECT_RATIO_16_10,	ASPECT_RATIO_21_9,	ASPECT_RATIO_32_9,
}


# Game states ------------------------------------------------------------------
enum GameState {
	INTRO,
	TITLE,
	LOADING,
}


# Input type -------------------------------------------------------------------
enum InputType {
	KEYBOARD_AND_MOUSE,
	PLAYSTATION_4_CONTOLLER,
	PLAYSTATION_5_CONTOLLER,
	XBOX_360_CONTROLLER,
	XBOX_ONE_SERIES_CONTROLLER,
}


# Locales ----------------------------------------------------------------------
enum Locale {
	EN_US,
	PT_BR,
	PT_PT,
	ES_ES,
	ES_LA,
	FR_FR,
	IT_IT,
	DE_DE,
	RU_RU,
	JA_JP,
	ZH_CN,
	ZH_TW,
	KO_KR,
}


# Playthrough slots ------------------------------------------------------------
enum PlaythroughSlot {
	SLOT_1,
	SLOT_2,
	SLOT_3,
	SLOT_4,
}


# Resolutions ------------------------------------------------------------------
enum Resolution {
	RESOLUTION_640_400,		RESOLUTION_640_480,		RESOLUTION_720_480,		RESOLUTION_800_600,
	RESOLUTION_960_540,		RESOLUTION_960_720,		RESOLUTION_1024_576,	RESOLUTION_1024_768,
	RESOLUTION_1140_900,	RESOLUTION_1152_648,	RESOLUTION_1152_768,	RESOLUTION_1280_720,
	RESOLUTION_1280_768,	RESOLUTION_1280_800,	RESOLUTION_1280_854,	RESOLUTION_1280_960,
	RESOLUTION_1280_1024,	RESOLUTION_1366_768,	RESOLUTION_1400_1050,	RESOLUTION_1440_960,
	RESOLUTION_1440_1080,	RESOLUTION_1600_900,	RESOLUTION_1600_1200,	RESOLUTION_1856_1392,
	RESOLUTION_1920_1080,	RESOLUTION_1920_1200,	RESOLUTION_1920_1440,	RESOLUTION_2048_1152,
	RESOLUTION_2048_1536,	RESOLUTION_2560_1080,	RESOLUTION_2560_1440,	RESOLUTION_2560_1600,
	RESOLUTION_2560_2048,	RESOLUTION_2880_1920,	RESOLUTION_3000_1800,	RESOLUTION_3440_1440,
	RESOLUTION_3840_1080,	RESOLUTION_3840_2160,	RESOLUTION_3840_2400,	RESOLUTION_5120_1440,
	RESOLUTION_5120_2160,	RESOLUTION_5120_4096,
}


# Scene screen -----------------------------------------------------------------
enum SceneScreen {
	INTRO_SCREEN,
	TITLE_SCREEN,
	GAME_SCREEN,
}


# Options state ----------------------------------------------------------------
enum OptionsState {
	CLOSED,
	ANIMATION,
	OPENED,
}

# Options sections -------------------------------------------------------------
enum OptionsSection {
	GAMEPLAY,
	VIDEO,
	AUDIO,
	EXIT,
}

# Options settings -------------------------------------------------------------
enum OptionsSetting {

	# Gameplay settings
	GAMEPLAY_LOCALE,

	# Audio settings
	AUDIO_VOLUME_MASTER,
	AUDIO_VOLUME_MUSIC,
	AUDIO_VOLUME_VOICE,
	AUDIO_VOLUME_AMBIENCE,
	AUDIO_VOLUME_SFX,
	AUDIO_VOLUME_GUI,

	# Video settings
	VIDEO_RESOLUTION,
	VIDEO_FULLSCREEN,

}

enum OptionsSettingType {
	CHECKBOX,
	COMBOLIST,
	SLIDER,
}