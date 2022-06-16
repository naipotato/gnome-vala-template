# configure and install the desktop file
configured_desktop_file = configure_file(
  input         : f'@rdnn_app_name@.desktop.in.in',
  output        : f'@rdnn_app_name@.desktop',
  configuration : {
    'ICON_NAME' : application_id,
    'COMMAND'   : meson.project_name(),
  },
)

desktop_file = i18n.merge_file(
  input       : configured_desktop_file,
  output      : f'@application_id@.desktop',
  po_dir      : meson.project_source_root() / 'po',
  type        : 'desktop',
  install     : true,
  install_dir : datadir / 'applications',
)

# validate the desktop file
desktop_file_validate = find_program('desktop-file-validate', required : false)

if desktop_file_validate.found()
  test(
    'validate-desktop-file',
    desktop_file_validate,

    args : desktop_file,
  )
endif

# configure and install the gschema file
configure_file(
  input         : f'@rdnn_app_name@.gschema.xml.in',
  output        : f'@application_id@.gschema.xml',
  install       : true,
  install_dir   : datadir / 'glib-2.0/schemas',
  configuration : {
    'APPLICATION_ID'  : application_id,
    'GETTEXT_PACKAGE' : gettext_package,
  },
)

# validate the gschema file
glib_compile_schemas = find_program('glib-compile-schemas', required : false)

if glib_compile_schemas.found()
  test(
    'validate-gschema-file',
    glib_compile_schemas,

    args : ['--strict', '--dry-run', meson.current_build_dir()]
  )
endif

subdir('icons')
