# Search simulator by name using JQ
# Takes the output of `xcrun simctl list devices -j`
# and filters using the given name.

def search_by_name($sim_name):
    .devices |
    to_entries |
    map(select(.key | contains("iOS"))) |
    .[].value[] |
    select(.name == $sim_name) |
    select(.availabilityError == null)
;

search_by_name($sim_name)
