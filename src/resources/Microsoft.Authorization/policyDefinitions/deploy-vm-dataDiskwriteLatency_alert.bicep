// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

targetScope = 'managementGroup'

param policyLocation string = 'centralus'
param parResourceGroupName string = 'AlzMonitoring-rg'
param parResourceGroupLocation string = 'centralus'
param parResourceGroupTags object = {
    environment: 'test'
}
param deploymentRoleDefinitionIds array = [
    '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
]

@allowed([
    '0'
    '1'
    '2'
    '3'
    '4'
])
param parAlertSeverity string = '2'

@allowed([
    'PT5M'
    'PT15M'
    'PT30M'
    'PT1H'
    'PT6H'
    'PT12H'
    'P1D'
])
param parWindowSize string = 'PT15M'

@allowed([
    'Equals'
    'GreaterThan'
    'GreaterThanOrEqual'
    'LessThan'
    'LessThanOrEqual'

])
param parOperator string = 'GreaterThan'

@allowed([
    'PT1M'
    'PT5M'
    'PT15M'
    'PT30M'
    'PT1H'
])
param parEvaluationFrequency string = 'PT5M'

@allowed([
    'deployIfNotExists'
    'disabled'
])
param parPolicyEffect string = 'deployIfNotExists'

param parAutoMitigate string = 'true'

param parautoResolve string = 'true'

param parautoResolveTime string = '00:10:00'

param parAlertState string = 'true'

param parThreshold string = '30'

param parEvaluationPeriods string = '1'

param parFailingPeriods string  = '1'

@allowed([
  'Average'
  'Count'
  'Maximum'
  'Minimum'
  'Total'
])



param parTimeAggregation string = 'Average'

param parComputersToInclude array = [
    '*'
     
]


param parDisksToInclude array = [
   '*'
]


//param parMonitorDisable string = 'MonitorDisable' 

module VMdataDiskWriteLatencyAlert '../../arm/Microsoft.Authorization/policyDefinitions/managementGroup/deploy.bicep' = {
    name: '${uniqueString(deployment().name)}-vmama-policyDefinitions'
    params: {
        name: 'Deploy_VM_dataDiskWriteLatency_Alert'
        displayName: 'Deploy VM Data Disk Write Latency Alert'
         description: 'Policy to audit/deploy VM dataDiskWriteLatency Alert'
        location: policyLocation
        metadata: {
            version: '1.0.0'
            category: 'Compute'
            source: 'https://github.com/Azure/Enterprise-Scale/' 
            alzCloudEnvironments: [ 
               'AzureCloud'
              ]
        }
        parameters: {
            alertResourceGroupName: {
                type: 'String'
                metadata: {
                    displayName: 'Resource Group Name'
                    description: 'Resource group the alert is placed in'
                }
                defaultValue: parResourceGroupName
            }
            alertResourceGroupTags: {
                type: 'Object'
                metadata: {
                    displayName: 'Resource Group Tags'
                    description: 'Tags on the Resource group the alert is placed in'
                }
                defaultValue: parResourceGroupTags
            }
            alertResourceGroupLocation: {
                type: 'String'
                metadata: {
                    displayName: 'Resource Group Location'
                    description: 'Location of the Resource group the alert is placed in'
                }
                defaultValue: parResourceGroupLocation
            }
            severity: {
                type: 'String'
                metadata: {
                    displayName: 'Severity'
                    description: 'Severity of the Alert'
                }
                allowedValues: [
                    '0'
                    '1'
                    '2'
                    '3'
                    '4'
                ]
                defaultValue: parAlertSeverity
            }
            operator: {
                type: 'String'
                metadata:{ displayName: 'Operator'}
                allowedvalues:[
                'Equals'
                'GreaterThan'
                'GreaterThanOrEqual'
                'LessThan'
                'LessThanOrEqual'
            ]
            defaultvalue: parOperator
        }
        timeAggregation:{
            type:'String'
            metadata: {
              displayName: 'TimeAggregation'
          }
          allowedValues:[
            'Average'
            'Count'
            'Maximum'
            'Minimum'
            'Total'

          ]

          defaultvalue: parTimeAggregation

        }

         
            windowSize: {
                type: 'String'
                metadata: {
                    displayName: 'Window Size'
                    description: 'Window size for the alert'
                }
                allowedValues: [
                    
                    'PT5M'
                    'PT15M'
                    'PT30M'
                    'PT1H'
                    'PT6H'
                    'PT12H'
                    'PT24H'
                ]
                defaultValue: parWindowSize
            }
            evaluationFrequency: {
                type: 'String'
                metadata: {
                    displayName: 'Evaluation Frequency'
                    description: 'Evaluation frequency for the alert'
                }
                allowedValues: [
                    'PT5M'
                    'PT15M'
                    'PT30M'
                    'PT1H'
                ]
                defaultValue: parEvaluationFrequency
            }
            autoMitigate: {
                type: 'String'
                metadata: {
                    displayName: 'Auto Mitigate'
                    description: 'Auto Mitigate for the alert'
                }
                allowedValues: [
                    'true'
                    'false'
                ]
                defaultValue: parAutoMitigate
            }
            autoResolve: {
                type: 'String'
                metadata: {
                    displayName: 'Auto Resolve'
                    description: 'Auto Resolve for the alert'
                }
                allowedValues: [
                    'true'
                    'false'
                ]
                defaultValue: parautoResolve
            }

            autoResolveTime: {
                type: 'String'
                metadata: {
                    displayName: 'Auto Resolve'
                    description: 'Auto Resolve time for the alert in ISO 8601 format'
                }
           
                defaultValue: parautoResolveTime
            }
            enabled: {
                type: 'String'
                metadata: {
                    displayName: 'Alert State'
                    description: 'Alert state for the alert'
                }
                allowedValues: [
                    'true'
                    'false'
                ]
                defaultValue: parAlertState
            }
     
            threshold: {
                type: 'String'
                metadata: {
                    displayName: 'Threshold'
                    description: 'Threshold for the alert'
                }
                defaultValue: parThreshold
            }

            failingPeriods: {
                type: 'String'
                metadata:{
                    disaplayname: 'Failing Periods'
                    description: 'Number of failing periods before alert is fired'
                }
                defaultValue: parFailingPeriods
            }
            evaluationPeriods: {
                type: 'String'
                metadata:{
                    displayname: 'Evaluation Periods'
                    description: 'The number of aggregated lookback points.'
                }
                defaultValue: parEvaluationPeriods
            }
            computersToInclude:{
                type: 'array'
                metadata:{
                    displayname:'Disks to be included to be monitored'
                    description: 'Array of Computer to be monitored'
                }

                defaultValue: parComputersToInclude

            } 
            disksToInclude:{
                type: 'array'
                metadata:{
                    displayname:'Disks to be included to be monitored'
                    description: 'Array of disk to be monitored for disk both windows and linux'
                }

                defaultValue: parDisksToInclude

            } 

            effect: {
                type: 'String'
                metadata: {
                    displayName: 'Effect'
                    description: 'Effect of the policy'
                }
                allowedValues: [
                    'deployIfNotExists'
                    'disabled'
                ]
                defaultValue: parPolicyEffect
            }
        
        }
        policyRule: {
            if: {
                allOf: [
                    {
                        field: 'type'
                        equals: 'Microsoft.Compute/virtualMachines'
                    }

                   ]
            }
            then: {
                effect: '[parameters(\'effect\')]'
                details: {
                    roleDefinitionIds: deploymentRoleDefinitionIds
                    type: 'Microsoft.Insights/scheduledQueryRules'
                    existenceScope: 'resourcegroup'
                    resourceGroupName: '[parameters(\'alertResourceGroupName\')]'
                    deploymentScope: 'subscription'
                    existenceCondition: {
                        allOf: [
               
                            {
                                field: 'Microsoft.Insights/scheduledQueryRules/displayName'
                                equals: '[concat(subscription().displayName, \'-VMLowdataDiskWriteLatencyAlert\')]'
                            }
                            {
                                field: 'Microsoft.Insights/scheduledqueryrules/scopes[*]'
                                equals: '[subscription().id]'
                            }
                            {
                                field: 'Microsoft.Insights/scheduledqueryrules/enabled'
                                equals: '[parameters(\'enabled\')]'
                            }
                        ]
                    }
                    deployment: {
                        location:policyLocation
                        properties: {
                            mode: 'incremental'
                               template: {
                                '$schema': 'https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
                                contentVersion: '1.0.0.0'
                                parameters: {

                                   policyLocation: {
                                        type: 'string'
                                        defaultValue: policyLocation
                                    }

                                    alertResourceGroupName: {
                                        type: 'string'
                                    }
                                    alertResourceGroupTags: {
                                        type: 'object'
                                    }
                                    alertResourceGroupLocation: {
                                        type: 'string'
                                    }
                                
                                    severity: {
                                        type: 'String'
                                    }
                                    windowSize: {
                                        type: 'String'
                                    }
                                    evaluationFrequency: {
                                        type: 'String'
                                    }
                                    autoMitigate: {
                                        type: 'String'
                                    }
                                    autoResolve: {
                                        type: 'String'
                                    }
                                    autoResolveTime: {
                                        type: 'String'
                                    }
                                    enabled: {
                                        type: 'String'
                                    }
                                    threshold: {
                                        type: 'String'
                                    }
                                    operator: {
                                        type:'String'

                                    }
                                    timeAggregation: {
                                        type:'String'

                                    }
                                    failingPeriods: {
                                        type:'String'

                                    }
                                    evaluationPeriods: {
                                        type:'String'

                                    }
                                    disksToInclude: {
                                        type:'array'

                                    }
                                    computersToInclude: {
                                        type:'array'

                                    }


                                }
                                variables: {}
                                resources: [
                                    {
                                        type: 'Microsoft.Resources/resourceGroups'
                                        apiVersion: '2021-04-01'
                                        name: '[parameters(\'alertResourceGroupName\')]'
                                        location: '[parameters(\'alertResourceGroupLocation\')]'
                                        tags: '[parameters(\'alertResourceGroupTags\')]'
                                    }
                                    {
                                        type: 'Microsoft.Resources/deployments'
                                        apiVersion: '2019-10-01'
                                        name: 'VMdataDiskWriteLatencyAlert'
                                        resourceGroup: '[parameters(\'alertResourceGroupName\')]'
                                        dependsOn: [
                                            '[concat(\'Microsoft.Resources/resourceGroups/\', parameters(\'alertResourceGroupName\'))]'
                                        ]
                                        properties: {
                                            mode: 'Incremental'
                                            template: {
                                                '$schema': 'https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
                                                contentVersion: '1.0.0.0'
                                                parameters: {
                                                    enabled: {
                                                        type: 'string'
                                                    }
                                                    alertResourceGroupName: {
                                                        type: 'string'
                                                    }
                                                    alertResourceGroupLocation:{
                                                        type:'string'
                                                    }
                                                }
                                                variables: {}
                                                resources: [
                                                    {
                                                        type: 'Microsoft.Insights/scheduledQueryRules'
                                                        apiVersion: '2022-08-01-preview'
                                                        name: '[concat(subscription().displayName, \'-VMHighdataDiskWriteLatencyAlert\')]'
                                                        location: '[parameters(\'alertResourceGroupLocation\')]'
                                                        properties: {
                                                            displayName: '[concat(subscription().displayName, \'-VMHighdataDiskWriteLatencyAlert\')]'
                                                            description: 'Log Alert for Virtual Machine dataDiskWriteLatency'
                                                            severity: '[parameters(\'severity\')]'
                                                            enabled: '[parameters(\'enabled\')]'
                                                            scopes: [
                                                                '[subscription().Id]'
                                                            ]
                                                            targetResourceTypes: [
                                                                'Microsoft.Compute/virtualMachines'
                                                            ]
                                                            evaluationFrequency: '[parameters(\'evaluationFrequency\')]'
                                                            windowSize: '[parameters(\'windowSize\')]'
                                                            criteria: {
                                                                allOf: [
                                                                    {
                                                                        query: 'InsightsMetrics| where Origin == "vm.azm.ms"| where Namespace == "LogicalDisk" and Name == "WriteLatencyMs"| extend Disk=tostring(todynamic(Tags)["vm.azm.ms/mountId"])|where Disk !in (\'C:\',\'/\')| summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId, Disk'
                                                                        metricMeasureColumn: 'AggregatedValue'
                                                                        threshold: '[parameters(\'threshold\')]'
                                                                        operator: '[parameters(\'operator\')]'
                                                                        resourceIdColumn: '_ResourceId'
                                                                        timeAggregation: '[parameters(\'timeAggregation\')]'
                                                                        dimensions:[
                                                                            {
                                                                                name: 'Computer'
                                                                                operator: 'Include'
                                                                                values: '[parameters(\'computersToInclude\')]'
                                                                            }    
                                                                            
                                                                            {
                                                                                name: 'Disk'
                                                                                operator: 'Include'
                                                                                values: '[parameters(\'disksToInclude\')]'
                                                                            }  
                                                                            
                
                                                                        ]
                                                                        failingPeriods:{
                                                                            numberOfEvaluationPeriods: '[parameters(\'evaluationPeriods\')]'
                                                                            minFailingPeriodsToAlert: '[parameters(\'failingPeriods\')]'
                                                                        }
                                                                    }
                                                                ]
                                                             
                                                            }
                                                            autoMitigate: '[parameters(\'autoMitigate\')]'
                                                            ruleResolveConfiguration: {
                                                                autoResolved: '[parameters(\'autoResolve\')]'
                                                                timeToResolve: '[parameters(\'autoResolveTime\')]'
                                                              }
                                                          
                                                            parameters: {

                                                                alertResourceGroupName: {
                                                                    value: '[parameters(\'alertResourceGroupName\')]'
                                                                }
                                                                alertResourceGroupLocation: {
                                                                    value: '[parameters(\'alertResourceGroupName\')]'
                                                                }
                                                                severity: {
                                                                    value: '[parameters(\'severity\')]'
                                                                }
                                                                windowSize: {
                                                                    value: '[parameters(\'windowSize\')]'
                                                                }
                                                                evaluationFrequency: {
                                                                    value: '[parameters(\'evaluationFrequency\')]'
                                                                }
                                                                autoMitigate: {
                                                                    value: '[parameters(\'autoMitigate\')]'
                                                                }
                                                                autoResolve: {
                                                                    value: '[parameters(\'autoResolve\')]'
                                                                }
                                                                autoResolveTime: {
                                                                    value: '[parameters(\'autoResolveTime\')]'
                                                                }
                                                                enabled: {
                                                                    value: '[parameters(\'enabled\')]'
                                                                }
                                                                threshold: {
                                                                    value: '[parameters(\'threshold\')]'
                                                                }
                                                                failingPeriods: {
                                                                    value: '[parameters(\'failingPeriods\')]'
                                                                               }
                                                                evaluationPeriods: {
                                                                    value:'[parameters(\'evaluationPeriods\')]'                            
                                                                }
                                                                disksToInclude: {
                                                                    value:'[parameters(\'disksToInclude\')]'                            
                                                                }
                                                                computersToInclude: {
                                                                    value:'[parameters(\'computersToInclude\')]'                            
                                                                }
                                                         
                                                            }
                                                        }
                                                    }
                                                ]
                                            }
                                            parameters: {
                                                enabled: {
                                                    value: '[parameters(\'enabled\')]'
                                                }
                                                alertResourceGroupName: {
                                                    value: '[parameters(\'alertResourceGroupName\')]'
                                                }

                                                alertResourceGroupLocation: {
                                                    value: '[parameters(\'alertResourceGroupLocation\')]'
                                                }
                                            }
                                        }
                                    }
                                
                                ]
                            }
                            parameters: {
                                alertResourceGroupName: {
                                    value: '[parameters(\'alertResourceGroupName\')]'
                                }
                                alertResourceGroupTags: {
                                    value: '[parameters(\'alertResourceGroupTags\')]'
                                }
                                alertResourceGroupLocation: {
                                    value: '[parameters(\'alertResourceGroupLocation\')]'
                                }
                                severity: {
                                    value: '[parameters(\'severity\')]'
                                }
                                windowSize: {
                                    value: '[parameters(\'windowSize\')]'
                                }
                                evaluationFrequency: {
                                    value: '[parameters(\'evaluationFrequency\')]'
                                }
                                autoMitigate: {
                                    value: '[parameters(\'autoMitigate\')]'
                                  }
                              autoResolve: {
                                    value: '[parameters(\'autoResolve\')]'
                                }
                                autoResolveTime: {
                                    value: '[parameters(\'autoResolveTime\')]'
                                }
                                enabled: {
                                    value: '[parameters(\'enabled\')]'
                                }
                                threshold: {
                                    value: '[parameters(\'threshold\')]'
                                }
                                operator: {
                                    value: '[parameters(\'operator\')]'
                                }
                                timeAggregation: {
                                    value: '[parameters(\'timeAggregation\')]'
                                }
                                failingPeriods: {
                                    value: '[parameters(\'failingPeriods\')]'
                                }
                                evaluationPeriods: {
                                    value: '[parameters(\'evaluationPeriods\')]'

                                }
                                disksToInclude: {
                                    value: '[parameters(\'disksToInclude\')]'

                                }   
                                computersToInclude: {
                                    value: '[parameters(\'computersToInclude\')]'

                                }


                            }
                        }
                    }
                }
            }
        }
    }
}
