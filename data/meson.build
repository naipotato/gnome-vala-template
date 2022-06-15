# configure and install the desktop file
configured_desktop_file = configure_file(
  input         : rdnn_app_name + '.desktop.in.in',
  output        : rdnn_app_name + '.desktop',
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

subdir('icons')
