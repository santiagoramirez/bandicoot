/// Determine if [property] is in [properties] list.
bool isInProperties(String property, List<String>? properties) {
  return properties == null ||
      (properties.length > 0 && properties.contains(property));
}

/// Determine if [propertyGroups] intersects with [groups].
bool isInGroups(List<String>? propertyGroups, List<String>? groups) {
  bool hasGroups = groups != null && groups.length > 0;

  bool hasGroupsWithoutPropertyGroups = (hasGroups && propertyGroups == null);

  bool hasGroupsWithPropertyGroups = (hasGroups &&
      propertyGroups != null &&
      propertyGroups.length > 0 &&
      propertyGroups.any((g) => groups.contains(g)));

  return (!hasGroups ||
      hasGroupsWithoutPropertyGroups ||
      hasGroupsWithPropertyGroups);
}
