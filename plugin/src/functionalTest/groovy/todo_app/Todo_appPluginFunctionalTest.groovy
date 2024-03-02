/*
 * This Groovy source file was generated by the Gradle 'init' task.
 */
package todo_app

import spock.lang.Specification
import spock.lang.TempDir
import org.gradle.testkit.runner.GradleRunner

/**
 * A simple functional test for the 'todo_app.greeting' plugin.
 */
class Todo_appPluginFunctionalTest extends Specification {
    @TempDir
    private File projectDir

    private getBuildFile() {
        new File(projectDir, "build.gradle")
    }

    private getSettingsFile() {
        new File(projectDir, "settings.gradle")
    }

    def "can run task"() {
        given:
        settingsFile << ""
        buildFile << """
plugins {
    id('todo_app.greeting')
}
"""

        when:
        def runner = GradleRunner.create()
        runner.forwardOutput()
        runner.withPluginClasspath()
        runner.withArguments("greeting")
        runner.withProjectDir(projectDir)
        def result = runner.build()

        then:
        result.output.contains("Hello from plugin 'todo_app.greeting'")
    }
}
