project(
  'gnome-vala-template',
  'vala', 'c',

  default_options : 'warning_level=2',
  # license       : 'MIT',
  meson_version   : '>=0.59.0',
  version         : '0.1.0',
)

# import modules
gnome = import('gnome')
i18n  = import('i18n')

# common dirs
prefix    = get_option('prefix')
datadir   = prefix / get_option('datadir')
localedir = prefix / get_option('localedir')

# info about the app
profile         = get_option('profile')
rdnn_app_name   = 'com.nahuelwexd.GnomeValaTemplate'
app_id_suffix   = profile == 'devel' ? '.Devel' : ''
application_id  = f'@rdnn_app_name@@app_id_suffix@'
resource_path   = '/' + rdnn_app_name.replace('.', '/')
version         = meson.project_version() + '-@VCS_TAG@'
gettext_package = meson.project_name()

# generate a header with the info
config_h_in = configure_file(
  output        : 'config.h.in',
  configuration : {
    'APPLICATION_ID' : f'"@application_id@"',
    'RESOURCE_PATH'  : f'"@resource_path@"',
    'VERSION'        : f'"@version@"',
    'GETTEXT_PACKAGE': f'"@gettext_package@"',
    'LOCALEDIR'      : f'"@localedir@"',
  },
)

vcs_tag(
  command  : ['git', 'rev-parse', '--short', 'HEAD'],
  fallback : profile,
  input    : config_h_in,
  output   : 'config.h',
)

# add some extra arguments
add_project_arguments(
  '--enable-checking',
  '--nostdpkg',
  '--define=' + profile.to_upper(),

  language : 'vala',
)

add_project_arguments(
  '-I' + meson.project_build_root(),
  f'-DGETTEXT_PACKAGE=@gettext_package@',
  '-DG_LOG_DOMAIN="GnomeValaTemplate"',

  language : 'c',
)

# define project dependencies
valac   = meson.get_compiler('vala')
vapidir = meson.project_source_root() / 'vapi'

adwaita_dep = dependency('libadwaita-1', version : '>=1.0', method : 'pkg-config')
config_dep  = valac.find_library('config', dirs : vapidir)
gio_dep     = dependency('gio-2.0', version : '>=2.70', method : 'pkg-config')

# subdirectories
subdir('data')
subdir('src')
subdir('po')

# post install scripts
gnome.post_install(
  gtk_update_icon_cache   : true,
  update_desktop_database : true,
)
