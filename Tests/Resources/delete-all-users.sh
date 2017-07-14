#!/bin/bash
#Get the name of database
EasyMinerDbName=`mysql --host=easyminer-mysql --user=root --password=root  --execute='show databases like "%000" ' | head -4 | tail -1 | tr -d "|"`
# Delete all rows in all tables using mariadb-client
mysql --host=easyminer-mysql --user=root --password=root --database=`echo $EasyMinerDbName` --execute="\
Delete from attributes                   ; \
Delete from cedents                      ; \
Delete from cedents_relations            ; \
Delete from cedents_rule_attributes      ; \
Delete from datasources                  ; \
Delete from datasource_columns           ; \
Delete from formats                      ; \
Delete from helper_data                  ; \
Delete from intervals                    ; \
Delete from knowledge_bases              ; \
Delete from knowledge_base_rule_relations; \
Delete from metasources                  ; \
Delete from metasource_tasks             ; \
Delete from metasource_tasks_attributes  ; \
Delete from meta_attributes              ; \
Delete from miners                       ; \
Delete from outlier_tasks                ; \
Delete from preprocessings               ; \
Delete from preprocessings_values_bins   ; \
Delete from rules                        ; \
Delete from rule_attributes              ; \
Delete from rule_rule_relations          ; \
Delete from rule_sets                    ; \
Delete from rule_set_rule_relations      ; \
Delete from tasks                        ; \
Delete from users                        ; \
Delete from user_forgotten_passwords     ; \
Delete from \`values\`                   ; \
Delete from values_bins                  ; \
Delete from values_bins_intervals        ; \
Delete from values_bins_values           ; \
Alter table attributes                     auto_increment = 1; \
Alter table cedents                        auto_increment = 1; \
Alter table cedents_relations              auto_increment = 1; \
Alter table cedents_rule_attributes        auto_increment = 1; \
Alter table datasources                    auto_increment = 1; \
Alter table datasource_columns             auto_increment = 1; \
Alter table formats                        auto_increment = 1; \
Alter table helper_data                    auto_increment = 1; \
Alter table intervals                      auto_increment = 1; \
Alter table knowledge_bases                auto_increment = 1; \
Alter table knowledge_base_rule_relations  auto_increment = 1; \
Alter table metasources                    auto_increment = 1; \
Alter table metasource_tasks               auto_increment = 1; \
Alter table metasource_tasks_attributes    auto_increment = 1; \
Alter table meta_attributes                auto_increment = 1; \
Alter table miners                         auto_increment = 1; \
Alter table outlier_tasks                  auto_increment = 1; \
Alter table preprocessings                 auto_increment = 1; \
Alter table preprocessings_values_bins     auto_increment = 1; \
Alter table rules                          auto_increment = 1; \
Alter table rule_attributes                auto_increment = 1; \
Alter table rule_rule_relations            auto_increment = 1; \
Alter table rule_sets                      auto_increment = 1; \
Alter table rule_set_rule_relations        auto_increment = 1; \
Alter table tasks                          auto_increment = 1; \
Alter table users                          auto_increment = 1; \
Alter table user_forgotten_passwords       auto_increment = 1; \
Alter table \`values\`                     auto_increment = 1; \
Alter table values_bins                    auto_increment = 1; \
Alter table values_bins_intervals          auto_increment = 1; \
Alter table values_bins_values             auto_increment = 1;"         