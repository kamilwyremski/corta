<!doctype html>
<html lang="{{ settings.lang }}">
<head>
  	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="Keywords" content="{{ settings.seo_keywords|default(settings.keywords) }}">
	<meta name="Description" content="{{ settings.seo_description|default(settings.description) }}">
	<title>{{ settings.seo_title|default(settings.title) }}</title>
	<base href="{{ settings.base_url }}/">
	{% block head %}
	{% endblock %}

	<!-- CSS style -->
	{% block css %}
		<link rel="stylesheet" href="views/{{ settings.template }}/css/bootstrap.min.css"/>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
		<link rel="stylesheet" href="views/{{ settings.template }}/css/style.css?{{ settings.assets_version }}"/>
		{% if settings.favicon %}<link rel="shortcut icon" href="{{ settings.favicon }}">{% endif %}
		{% if settings.code_style %}<style>{{ settings.code_style|raw }}</style>{% endif %}
	{% endblock %}

	<!-- integration with Facebook -->
	{% if settings.logo_facebook  %}<meta property="og:image" content="{{ settings.logo_facebook }}">{% endif %}
	<meta property="og:description" content="{{ settings.seo_description|default(settings.description) }}">
	<meta property="og:title" content="{{ settings.seo_title|default(settings.title) }}">
	<meta property="og:type" content="website">
	<meta property="og:site_name" content="{{ settings.seo_title|default(settings.title) }}">
	<meta property="og:locale" content="{{ settings.facebook_lang }}">
	{% if settings.facebook_api %}<meta property="fb:app_id" content="{{ settings.facebook_api }}">{% endif %}

	<!-- other -->
	{{ settings.code_head|raw }}
</head>
<body>
	<nav class="navbar fixed-top navbar-expand-md navbar-light" id="menu_box">
		<a class="navbar-brand" href="{{ settings.base_url }}" title="{{ settings.title }}">{% if settings.logo %}<img src="{{ settings.logo }}" alt="{{ settings.title }}">{% else %}{{ settings.title }}{% endif %}</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="menu">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item {% if controller=='index' %}active{% endif %}"><a href="{{ settings.base_url }}" title="{{ settings.title }}" class="nav-link">{{ 'Home'|trans }}</a></li>
				{% if settings.enable_articles %}<li class="nav-item {% if controller=='articles' %}active{% endif %}"><a href="{{ path('articles') }}" title="{{ 'Articles'|trans }}" class="nav-link">{{ 'Articles'|trans }}</a></li>{% endif %}
				<li class="nav-item {% if controller=='info' %}active{% endif %}"><a href="{{ path('info') }}" title="{{ 'Info about us'|trans }}" class="nav-link">{{ 'Info'|trans }}</a></li>
			</ul>
		</div>
	</nav>

	<div id="fb-root"></div>

	{% block content %}

	{% endblock %}

	{% if settings.ads_4 %}<div class="ads d-print-none">{{ settings.ads_4|raw }}</div>{% endif %}
	<footer>
		<div id="footer_top">
			<br>
			<div class="container">
				<div class="row">
					<div class="col-md-5">
						<h4>{{ 'Newsletter'|trans }}</h4>
						{% if newsletter_info %}
							<div class="alert alert-success" role="alert"><i class="fas fa-exclamation"></i> {{ newsletter_info }}</div>
							<div id="js_scroll_page"></div>
						{% elseif newsletter_error %}
							<div class="alert alert-danger" role="alert"><i class="fas fa-exclamation"></i> {{ newsletter_error }}</div>
						<div id="js_scroll_page"></div>
						{% endif %}
						<form action="" method="post">
							<input type="hidden" name="action" value="newsletter_add">
							<input type="hidden" name="token" value="{{ generateToken('newsletter_add') }}">
							<div class="form-group">
								<label for="newsletter_email">{{ 'E-mail address'|trans }}</label>
								<input class="form-control" type="email" name="email" placeholder="{{ 'example@example.com'|trans }}" required maxlength="64" value="{{ newsletter_input.email }}" id="newsletter_email">
							</div>
							<div class="form-group {% if error.captcha %}was-validated{% endif %}">
								{% if settings.recaptcha_site_key and settings.recaptcha_secret_key %}
									<input type="hidden" name="recaptcha_response" class="recaptchaResponse">
									<p><small>This site is protected by reCAPTCHA and the Google <a href="https://policies.google.com/privacy" target="_blank" rel="nofollow">Privacy Policy</a> and <a href="https://policies.google.com/terms" target="_blank" rel="nofollow">Terms of Service</a> apply.</small></p>
								{% else %}
									<label for="newsletter_captcha">{{ 'Captcha'|trans }}</label>
									<img src="{{ path('captcha') }}" alt="captcha">
									<input type="text" class="form-control" placeholder="abc123" title="{{ 'Enter the code Captcha'|trans }}" name="captcha" id="newsletter_captcha" required maxlength="32">
								{% endif %}
							</div>
							<div class="form-group">
								<div class="custom-control custom-checkbox">
									<input type="checkbox" name="rules" class="custom-control-input" id="newsletter_rules" required {% if newsletter_input.rules %}checked{% endif %}>
									<label class="custom-control-label" for="newsletter_rules">{{ 'Accepts the terms and conditions and the privacy policy'|trans }}</label>
								</div>
							</div>
							<input type="submit" class="btn btn-1 text-uppercase" value="{{ 'Subscribe'|trans }}">
						</form>
						<br><br>
					</div>
					<div class="col-md-4">
						<h4>{{ settings.title }}</h4>
						{{ settings.footer_top|raw }}
						<br><br>
					</div>
					<div class="col-md-3">
						<h4>{{ 'Sitemap'|trans }}</h4>
						<ul class="list-unstyled">
							<li><a class="main-color-2" href="{{ settings.base_url }}" title="{{ settings.title }}">{{ 'Home'|trans }}</a></li>
							<li><a class="main-color-2" href="{{ path('rules') }}" title="{{ 'Terms of service'|trans }}">{{ 'Terms of service'|trans }}</a><li>
			       			<li><a class="main-color-2" href="{{ path('privacy_policy') }}" title="{{ 'Privacy policy'|trans }}">{{ 'Privacy policy'|trans }}</a></li>
							<li><a class="main-color-2" href="{{ path('contact') }}" title="{{ 'Contact us'|trans }}">{{ 'Contact'|trans }}</a></li>
							<li><a class="main-color-2" href="{{ path('info') }}" title="{{ 'Info about us'|trans }}">{{ 'Info'|trans }}</a></li>
							{% if settings.enable_articles %}<li><a class="main-color-2" href="{{ path('articles') }}" title="{{ 'Articles'|trans }}">{{ 'Articles'|trans }}</a></li>{% endif %}
						</ul>
						<br><br>
					</div>
				</div>
			</div>
		</div>
		<div id="footer_bottom" class="text-center">
			{{ settings.footer_bottom|raw }}
			<!-- MIT licensed script. Deleting software author information is prohibited -->
			<p class="small">Corta 1.3 &copy; Project 2020 - 2022 by <a href="https://itworksbetter.net" target="_blank" title="Creating websites">IT Works Better</a></p>
		</div>
	</footer>

	<div id="cookies-message" class="text-center d-print-none"><div class="container"></div>{{ 'This site uses cookies, so that our service may work better.'|trans }} <a href="javascript:closeCookiesWindow();" id="accept-cookies-checkbox" class="btn btn-outline-light btn-sm">{{ 'I accept'|trans }}</a></div></div>

	{% if settings.facebook_side_panel %}
		<div id="facebook_side" class="d-none d-sm-block d-print-none">
			<div id="facebook_side_image"><img src="{{ settings.base_url }}/views/{{ settings.template }}/images/facebook-side.png" alt="Facebook" width="10" height="21"></div>
			<div class="fb-page" data-href="{{ settings.url_facebook }}" data-show-posts="true" data-width="300" data-height="350" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"><blockquote cite="{{ settings.url_facebook }}" class="fb-xfbml-parse-ignore"><a href="{{ settings.url_facebook }}">Facebook</a></blockquote></div>
		</div>
	{% endif %}

  {% if settings.rodo_alert %}
    <div class="modal fade" id="rodo-message">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-body">
          {{ settings.rodo_alert_text|raw }}
          </div>
          <div class="modal-footer">
            <a href="javascript:closeRodoWindow();" class="btn btn-1">{{ 'I agree to the processing my personal data'|trans }}</a>
          </div>
        </div>
      </div>
    </div>
  {% endif %}

	<!-- JS javascript -->
	{% block javascript %}
		<script src="js/jquery-3.5.1.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="views/{{ settings.template }}/js/engine.js?{{ settings.assets_version }}"></script>

		{% if settings.facebook_side_panel %}
			<script>(function(d, s, id) {
				var js, fjs = d.getElementsByTagName(s)[0];
				if (d.getElementById(id)) return;
				js = d.createElement(s); js.id = id;
				js.src = "//connect.facebook.net/{{ settings.facebook_lang|default(en_US) }}/all.js#xfbml=1";
				fjs.parentNode.insertBefore(js, fjs);
				}(document, 'script', 'facebook-jssdk'));
			</script>
		{% endif %}
		
		{% if settings.recaptcha_site_key and settings.recaptcha_secret_key %}
			<script src="https://www.google.com/recaptcha/api.js?render={{ settings.recaptcha_site_key }}"></script>
			<script>
				grecaptcha.ready(function () {
					grecaptcha.execute('{{ settings.recaptcha_site_key }}', { action: 'login' }).then(function (token) {
						var elms = document.getElementsByClassName('recaptchaResponse')
						for (var i = 0; i < elms.length; i++) {
							elms[i].setAttribute("value", token);
						}
					});
				});
			</script>
		{% endif %}

		{{ settings.analytics|raw }}

	{% endblock %}

	{{ settings.code_body|raw }}

</body>
</html>
