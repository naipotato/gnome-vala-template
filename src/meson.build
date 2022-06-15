gnome_vala_template_sources = [
  'Application.vala',
  'MainWindow.vala',
]

gnome_vala_template_sources += gnome.compile_resources(
  'gnome-vala-template-ui-resources',
  'gnome-vala-template-ui-resources.xml',
)

gnome_vala_template_deps = [
  adwaita_dep,
  config_dep,
  gio_dep,
]

executable(
  meson.project_name(),
  gnome_vala_template_sources,

  dependencies  : gnome_vala_template_deps,
  install       : true,
  win_subsystem : 'windows',
)
